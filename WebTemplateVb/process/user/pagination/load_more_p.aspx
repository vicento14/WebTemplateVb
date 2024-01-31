
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    'MS SQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    Dim method As String = Request.Form("method")

    If method = "count_account_list" Then
        Dim employee_no As String = Request.Form("employee_no")
        Dim full_name As String = Request.Form("full_name")
        Dim user_type As String = Request.Form("user_type")

        Dim MainClass As New Main
        Dim searchArr() As String = {employee_no, full_name, user_type}

        Dim ResponseData As String = MainClass.CountAccountList(searchArr, conn)

        Response.Write(ResponseData)
    End If

    If method = "search_account_list" Then
        Dim employee_no As String = Request.Form("employee_no")
        Dim full_name As String = Request.Form("full_name")
        Dim user_type As String = Request.Form("user_type")
        Dim current_page As String = Request.Form("current_page")

        Dim c As Integer = 0
        Dim ResponseData As String = ""

        Dim resultsPerPage As Integer = 5

        'determine the sql LIMIT starting number for the results on the displaying page
        Dim pageFirstResult As Integer = (current_page - 1) * resultsPerPage

        Dim sql As String = "SELECT * FROM user_accounts"
        sql += " WHERE id_number LIKE '" & employee_no & "%'"
        sql += " AND full_name LIKE '" & full_name & "%'"
        sql += " AND role LIKE '" & user_type & "%'"
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

                    ResponseData = "<tr style=cursor:pointer; class=modal-trigger "
                    ResponseData += "data-toggle=modal data-target=#update_account "
                    ResponseData += "data-id=" + reader.Item("id").ToString() + " "
                    ResponseData += "data-id_number=" + reader.Item("id_number").ToString() + " "
                    ResponseData += "data-username=" + HttpUtility.HtmlEncode(reader.Item("username").ToString()) + " "
                    ResponseData += "data-full_name=" + HttpUtility.HtmlEncode(reader.Item("full_name").ToString()) + " "
                    ResponseData += "data-password=" + HttpUtility.HtmlEncode(reader.Item("password").ToString()) + " "
                    ResponseData += "data-section=" + reader.Item("section").ToString() + " "
                    ResponseData += "data-role=" + reader.Item("role").ToString() + " "
                    ResponseData += "onclick=get_accounts_details(this)>"

                    ResponseData += "<td>" + c.ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("id_number").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("username").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("full_name").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("section").ToString() + "</td>"
                    ResponseData += "<td>" + reader.Item("role").ToString().ToUpper() + "</td>"

                    ResponseData += "</tr>"

                    Response.Write(ResponseData)
                End While
            Else
                ResponseData = "<tr><td colspan=6 style=text-align:center;color:red;>No Result !!!</td></tr>"
                Response.Write(ResponseData)
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            Response.Write("SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString())
        End Try
    End If

    If method = "account_list_last_page" Then
        Dim employee_no As String = Request.Form("employee_no")
        Dim full_name As String = Request.Form("full_name")
        Dim user_type As String = Request.Form("user_type")

        Dim MainClass As New Main
        Dim searchArr() As String = {employee_no, full_name, user_type}
        Dim ResponseData As String = ""

        Dim resultsPerPage As Integer = 5

        Dim numberOfResult As String = MainClass.CountAccountList(searchArr, conn)

        Dim numberOfPage As Integer = Math.Ceiling(numberOfResult / resultsPerPage)

        Response.Write(numberOfPage)
    End If
%>