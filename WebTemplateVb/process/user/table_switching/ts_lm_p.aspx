
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    'MS SQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    Dim method As String = Request.Form("method")

    If method = "count_t_t1_data" Then
        Dim MainClass As New Main

        Dim ResponseData As String = MainClass.CountTT1Data(conn)

        Response.Write(ResponseData)
    End If

    If method = "load_t_t1_data_last_page" Then
        Dim MainClass As New Main

        Dim resultsPerPage As Integer = 10

        Dim numberOfResult As String = MainClass.CountTT1Data(conn)

        Dim numberOfPage As Integer = Math.Ceiling(numberOfResult / resultsPerPage)

        Response.Write(numberOfPage)
    End If

    If method = "load_t_t1_data" Then
        Dim current_page As String = Request.Form("current_page")

        Dim c As Integer = 0
        Dim ResponseData As String = ""

        Dim resultsPerPage As Integer = 10

        'determine the sql LIMIT starting number for the results on the displaying page
        Dim pageFirstResult As Integer = (current_page - 1) * resultsPerPage

        Dim sql As String = "SELECT * FROM t_t1"
        sql += " ORDER BY id ASC"
        sql += " OFFSET " & pageFirstResult & " ROWS FETCH NEXT " & resultsPerPage & " ROWS ONLY"

        Dim cmd As New SqlCommand(sql, conn)

        c = pageFirstResult

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                While reader.Read()
                    c += 1

                    ResponseData += "<tr style=cursor:pointer; class=modal-trigger "
                    ResponseData += "data-id=" + reader.Item("id").ToString() + " "
                    ResponseData += "data-c1=" + reader.Item("c1").ToString() + " "
                    ResponseData += "onclick=load_t_t2(this)>"

                    ResponseData += "<td>" + c.ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("c1").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("c2").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("c3").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("c4").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("date_updated").ToString() + "</td>"

                    ResponseData += "</tr>"
                End While
            Else
                ResponseData += "<tr><td colspan=6 style=text-align:center;color:red;>No Result !!!</td></tr>"
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            ResponseData += "SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString()
        End Try

        Response.Write(ResponseData)
    End If

    If method = "count_t_t2_data" Then
        Dim c1 As String = Request.Form("c1")

        Dim MainClass As New Main

        Dim ResponseData As String = MainClass.CountTT2Data(c1, conn)

        Response.Write(ResponseData)
    End If

    If method = "load_t_t2_data_last_page" Then
        Dim c1 As String = Request.Form("c1")

        Dim MainClass As New Main

        Dim resultsPerPage As Integer = 10

        Dim numberOfResult As String = MainClass.CountTT2Data(c1, conn)

        Dim numberOfPage As Integer = Math.Ceiling(numberOfResult / resultsPerPage)

        Response.Write(numberOfPage)
    End If

    If method = "load_t_t2" Then
        Dim c1 As String = Request.Form("c1")
        Dim current_page As String = Request.Form("current_page")

        Dim c As Integer = 0
        Dim ResponseData As String = ""

        Dim resultsPerPage As Integer = 10

        'determine the sql LIMIT starting number for the results on the displaying page
        Dim pageFirstResult As Integer = (current_page - 1) * resultsPerPage

        Dim sql As String = "SELECT * FROM t_t2 WHERE c1 = '" & c1 & "'"
        sql += " ORDER BY id ASC"
        sql += " OFFSET " & pageFirstResult & " ROWS FETCH NEXT " & resultsPerPage & " ROWS ONLY"

        Dim cmd As New SqlCommand(sql, conn)

        c = pageFirstResult

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                While reader.Read()
                    c += 1

                    ResponseData += "<tr>"

                    ResponseData += "<td>" + c.ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("c1").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("d1").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("d2").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("d3").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("date_updated").ToString() + "</td>"

                    ResponseData += "</tr>"
                End While
            Else
                ResponseData += "<tr><td colspan=6 style=text-align:center;color:red;>No Result !!!</td></tr>"
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            ResponseData += "SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString()
        End Try

        Response.Write(ResponseData)
    End If
%>