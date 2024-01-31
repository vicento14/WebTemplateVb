
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    'MS SQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    Dim method As String = Request.Form("method")

    If method = "account_list" Then
        Dim c As Integer = 0
        Dim ResponseData As String = ""

        Dim sql As String = "SELECT * FROM user_accounts"
        Dim cmd As New SqlCommand(sql, conn)

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

    If method = "search_account_list" Then
        Dim employee_no As String = Request.Form("employee_no")
        Dim full_name As String = Request.Form("full_name")
        Dim user_type As String = Request.Form("user_type")
        Dim c As Integer = 0
        Dim ResponseData As String = ""

        Dim sql As String = "SELECT * FROM user_accounts"
        sql += " WHERE id_number LIKE '" & employee_no & "%'"
        sql += " AND full_name LIKE '" & full_name & "%'"
        sql += " AND role LIKE '" & user_type & "%'"
        Dim cmd As New SqlCommand(sql, conn)

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

    If method = "register_account" Then
        Dim employee_no As String = Trim(Request.Form("employee_no"))
        Dim full_name As String = Trim(Request.Form("full_name"))
        Dim username As String = Trim(Request.Form("username"))
        Dim password As String = Trim(Request.Form("password"))
        Dim section As String = Trim(Request.Form("section"))
        Dim user_type As String = Trim(Request.Form("user_type"))
        Dim ResponseData As String = ""

        Dim sql As String = "SELECT id FROM user_accounts WHERE username = @username"
        Dim cmd As New SqlCommand(sql, conn)
        With cmd
            .Parameters.Clear()
            .Parameters.AddWithValue("@username", username)
        End With

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                ResponseData = "Already Exist"
                Response.Write(ResponseData)
            Else
                reader.Close()

                sql = "INSERT INTO user_accounts (id_number, full_name, username, password, section, role)"
                sql += " VALUES (@id_number,@full_name,@username,@password,@section,@role)"
                cmd = New SqlCommand(sql, conn)
                With cmd
                    .Parameters.Clear()
                    .Parameters.AddWithValue("@id_number", employee_no)
                    .Parameters.AddWithValue("@full_name", full_name)
                    .Parameters.AddWithValue("@username", username)
                    .Parameters.AddWithValue("@password", password)
                    .Parameters.AddWithValue("@section", section)
                    .Parameters.AddWithValue("@role", user_type)
                End With
                cmd.ExecuteNonQuery()
                cmd.Dispose()

                ResponseData = "success"
                Response.Write(ResponseData)
            End If

            conn.Close()

        Catch ex As Exception
            Response.Write("SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString())
        End Try
    End If

    If method = "update_account" Then
        Dim id As String = Request.Form("id")
        Dim id_number As String = Trim(Request.Form("id_number"))
        Dim full_name As String = Trim(Request.Form("full_name"))
        Dim username As String = Trim(Request.Form("username"))
        Dim password As String = Trim(Request.Form("password"))
        Dim section As String = Trim(Request.Form("section"))
        Dim role As String = Trim(Request.Form("role"))
        Dim ResponseData As String = ""

        Dim sql As String = "SELECT id FROM user_accounts"
        sql += " WHERE username = @username"
        sql += " AND id_number = @id_number"
        sql += " AND full_name = @full_name"
        sql += " AND section = @section"
        Dim cmd As New SqlCommand(sql, conn)
        With cmd
            .Parameters.Clear()
            .Parameters.AddWithValue("@username", username)
            .Parameters.AddWithValue("@id_number", id_number)
            .Parameters.AddWithValue("@full_name", full_name)
            .Parameters.AddWithValue("@section", section)
        End With

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                ResponseData = "duplicate"
                Response.Write(ResponseData)
            Else
                reader.Close()

                sql = "UPDATE user_accounts"
                sql += " SET id_number = @id_number"
                sql += ", username = @username"
                sql += ", full_name = @full_name"
                sql += ", password = @password"
                sql += ", section = @section"
                sql += ", role = @role"
                sql += " WHERE id = @id"
                cmd = New SqlCommand(sql, conn)
                With cmd
                    .Parameters.Clear()
                    .Parameters.AddWithValue("@id_number", id_number)
                    .Parameters.AddWithValue("@full_name", full_name)
                    .Parameters.AddWithValue("@username", username)
                    .Parameters.AddWithValue("@password", password)
                    .Parameters.AddWithValue("@section", section)
                    .Parameters.AddWithValue("@role", role)
                    .Parameters.AddWithValue("@id", id)
                End With
                cmd.ExecuteNonQuery()
                cmd.Dispose()

                ResponseData = "success"
                Response.Write(ResponseData)
            End If

            conn.Close()

        Catch ex As Exception
            Response.Write("SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString())
        End Try
    End If

    If method = "delete_account" Then
        Dim id As String = Request.Form("id")
        Dim ResponseData As String = ""

        Dim sql As String = "DELETE FROM user_accounts WHERE id = @id"
        Dim cmd As New SqlCommand(sql, conn)
        With cmd
            .Parameters.Clear()
            .Parameters.AddWithValue("@id", id)
        End With

        Try
            conn.Open()

            cmd.ExecuteNonQuery()
            cmd.Dispose()

            ResponseData = "success"
            Response.Write(ResponseData)

            conn.Close()

        Catch ex As Exception
            Response.Write("SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString())
        End Try
    End If
%>