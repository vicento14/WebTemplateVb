
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    'MySQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    If Not String.IsNullOrEmpty(Request.Form("Login")) Then
        Dim username As String = Request.Form("username")
        Dim password As String = Request.Form("password")

        Dim sql As String = "SELECT full_name, section, role FROM user_accounts WHERE username = @username COLLATE SQL_Latin1_General_CP1_CS_AS AND password = @password COLLATE SQL_Latin1_General_CP1_CS_AS"
        Dim cmd As New SqlCommand(sql, conn)
        With cmd
            .Parameters.Clear()
            .Parameters.AddWithValue("@username", username)
            .Parameters.AddWithValue("@password", password)
        End With

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                'Session("loginError") = 0
                Session("loginError") = 1
                Session("loginErrorMsg") = "Sign In Success!!!"
                'Response.Write("<script>alert('Sign In Success!!!')</script>")

                'While reader.Read()
                '    Session("username") = username
                '    Session("name") = reader.Item("full_name").ToString()
                '    Session("section") = reader.Item("section").ToString()
                '    Session("role") = reader.Item("role").ToString()
                'End While
                ''add session("login")
                ''redirect to index
                'Session.Timeout = 240
                'If Session("role") = "admin" Then
                '    Response.Redirect("../page/admin/dashboard.aspx")
                'ElseIf Session("role") = "user" Then
                '    Response.Redirect("../page/user/pagination.aspx")
                'End If
            Else
                'redirect to index with failed response
                Session("loginError") = 1
                Session("loginErrorMsg") = "Sign In Failed. Maybe an incorrect credential or account not found"
                'Response.Write("<script>alert('Sign In Failed. Maybe an incorrect credential or account not found')</script>")
                Response.Redirect("../index.aspx")
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            Session("loginError") = 1
            Session("loginErrorMsg") = "SYSTEM ERROR:\n" + ex.Message
            Session("loginErrorConsoleMsg") = "SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString()
            'Response.Write("<script>alert(`SYSTEM ERROR:\n" + ex.Message + "`)</script>")
            'Response.Write("<script>console.log(`SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString() + "`)</script>")
            Response.Redirect("../index.aspx")
        End Try

    End If
%>