
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    'MS SQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    Dim method As String = Request.Form("method")

    If method = "load_t_t1" Then
        Dim c As Integer = 0
        Dim ResponseData As String = ""

        ResponseData += "<thead style=text-align:center;>"
        ResponseData += "<tr>"
        ResponseData += "<th> # </th>"
        ResponseData += "<th> C1 </th>"
        ResponseData += "<th> C2 </th>"
        ResponseData += "<th> C3 </th>"
        ResponseData += "<th> C4 </th>"
        ResponseData += "<th> Date Updated </th>"
        ResponseData += "</tr>"
        ResponseData += "</thead>"
        ResponseData += "<tbody id=t_t1_data style=text-align:center;>"

        Dim sql As String = "SELECT * FROM t_t1"
        Dim cmd As New SqlCommand(sql, conn)

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

        ResponseData += "</tbody>"

        Response.Write(ResponseData)
    End If

    If method = "load_t_t2" Then
        Dim c1 As String = Request.Form("c1")

        Dim c As Integer = 0
        Dim ResponseData As String = ""

        ResponseData += "<thead style=text-align:center;>"
        ResponseData += "<tr>"
        ResponseData += "<th> # </th>"
        ResponseData += "<th> C1 </th>"
        ResponseData += "<th> D1 </th>"
        ResponseData += "<th> D2 </th>"
        ResponseData += "<th> D3 </th>"
        ResponseData += "<th> Date Updated </th>"
        ResponseData += "</tr>"
        ResponseData += "</thead>"
        ResponseData += "<tbody id=t_t2_data style=text-align:center;>"

        Dim sql As String = "SELECT * FROM t_t2 WHERE c1 = '" & c1 & "'"
        Dim cmd As New SqlCommand(sql, conn)

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

        ResponseData += "</tbody>"

        Response.Write(ResponseData)
    End If
%>