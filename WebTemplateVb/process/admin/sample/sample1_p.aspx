
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<%
    'MS SQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    Dim method As String = Request.Form("method")

    If method = "account_list" Then
        Dim ResponseData As New ArrayList()

        Dim sql As String = "SELECT * FROM user_accounts"
        Dim cmd As New SqlCommand(sql, conn)

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                While reader.Read()
                    Dim Rows As Dictionary(Of String, String) = New Dictionary(Of String, String) From {}

                    Rows.Add("id", reader.Item("id").ToString())
                    Rows.Add("id_number", reader.Item("id_number").ToString())
                    Rows.Add("username", HttpUtility.HtmlEncode(reader.Item("username").ToString()))
                    Rows.Add("full_name", HttpUtility.HtmlEncode(reader.Item("full_name").ToString()))
                    Rows.Add("section", reader.Item("section").ToString())
                    Rows.Add("role", reader.Item("role").ToString())

                    ResponseData.Add(Rows)
                End While
            Else
                Dim Rows As Dictionary(Of String, String) = New Dictionary(Of String, String) From {}
                Rows.Add("message", "No Results Found")
                ResponseData.Add(Rows)
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            Response.Write("SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString())
        End Try

        Dim ResponseDataJson As String = JsonConvert.SerializeObject(ResponseData)
        Response.Write(ResponseDataJson)
    End If

    If method = "search_account_list" Then
        Dim employee_no As String = Request.Form("employee_no")
        Dim full_name As String = Request.Form("full_name")
        Dim user_type As String = Request.Form("user_type")

        Dim ResponseData As New ArrayList()

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
                    Dim Rows As Dictionary(Of String, String) = New Dictionary(Of String, String) From {}

                    Rows.Add("id", reader.Item("id").ToString())
                    Rows.Add("id_number", reader.Item("id_number").ToString())
                    Rows.Add("username", HttpUtility.HtmlEncode(reader.Item("username").ToString()))
                    Rows.Add("full_name", HttpUtility.HtmlEncode(reader.Item("full_name").ToString()))
                    Rows.Add("section", reader.Item("section").ToString())
                    Rows.Add("role", reader.Item("role").ToString())

                    ResponseData.Add(Rows)
                End While
            Else
                Dim Rows As Dictionary(Of String, String) = New Dictionary(Of String, String) From {}
                Rows.Add("message", "No Results Found")
                ResponseData.Add(Rows)
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            Response.Write("SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString())
        End Try

        Dim ResponseDataJson As String = JsonConvert.SerializeObject(ResponseData)
        Response.Write(ResponseDataJson)
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
                sql += ", section = @section"
                sql += ", role = @role"

                If Not String.IsNullOrEmpty(password) Then
                    sql += ", password = @password"
                End If

                sql += " WHERE id = @id"

                cmd = New SqlCommand(sql, conn)

                With cmd
                    .Parameters.Clear()
                    .Parameters.AddWithValue("@id_number", id_number)
                    .Parameters.AddWithValue("@full_name", full_name)
                    .Parameters.AddWithValue("@username", username)
                    .Parameters.AddWithValue("@section", section)
                    .Parameters.AddWithValue("@role", role)
                End With

                If Not String.IsNullOrEmpty(password) Then
                    cmd.Parameters.AddWithValue("@password", password)
                End If

                cmd.Parameters.AddWithValue("@id", id)

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

    If method = "delete_account_selected" Then
        Dim id_arr As New ArrayList()
        Dim ResponseData As String = ""

        For Each key As String In Request.Form.AllKeys
            If key.StartsWith("id_arr[") AndAlso key.EndsWith("]") Then
                Dim value As Integer = Request.Form(key)
                id_arr.Add(value)
            End If
        Next

        Dim count As Integer = id_arr.Count()

        For Each id As Integer In id_arr
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

                conn.Close()

                count -= 1

            Catch ex As Exception
                Response.Write("SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString())
            End Try
        Next

        If count = 0 Then
            ResponseData = "success"
            Response.Write(ResponseData)
        End If
    End If
%>