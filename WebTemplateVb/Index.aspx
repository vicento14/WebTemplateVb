<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Index.aspx.vb" Inherits="_Default" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="MySql.Data.MySqlClient" %>

<%
    'MS SQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    'MySQL Connection
    'Dim conn_str As String = ConfigurationManager.ConnectionStrings("MySqlConnection1").ToString
    'Dim conn As MySqlConnection = New MySqlConnection(conn_str)

    If Not String.IsNullOrEmpty(Request.Form("Login")) Then
        Dim username As String = Request.Form("username")
        Dim password As String = Request.Form("password")

        Dim sql As String = "SELECT full_name, section, role FROM user_accounts"
        sql += " WHERE username = @username COLLATE SQL_Latin1_General_CP1_CS_AS"
        sql += " AND password = @password COLLATE SQL_Latin1_General_CP1_CS_AS"
        'Dim sql As String = "SELECT full_name, section, role FROM user_accounts"
        'sql += " WHERE BINARY username = @username"
        'sql += " AND BINARY password = @password"
        Dim cmd As New SqlCommand(sql, conn)
        'Dim cmd As New MySqlCommand(sql, conn)
        With cmd
            .Parameters.Clear()
            .Parameters.AddWithValue("@username", username)
            .Parameters.AddWithValue("@password", password)
        End With

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                'Response.Write("<script>alert('Sign In Success!!!')</script>")

                While reader.Read()
                    Session("username") = username
                    Session("name") = reader.Item("full_name").ToString()
                    Session("section") = reader.Item("section").ToString()
                    Session("role") = reader.Item("role").ToString()
                End While

                'redirect to page based on role
                Session.Timeout = 240
                If Session("role") = "admin" Then
                    Response.Redirect("page/admin/dashboard.aspx")
                ElseIf Session("role") = "user" Then
                    Response.Redirect("page/user/pagination.aspx")
                End If
            Else
                'redirect to index with failed response
                Response.Write("<script>alert('Sign In Failed. Maybe an incorrect credential or account not found')</script>")
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            Response.Write("<script>alert(`SYSTEM ERROR:\n" + ex.Message + "`)</script>")
            Response.Write("<script>console.log(`SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString() + "`)</script>")
        End Try

    End If

    If Not String.IsNullOrEmpty(Session("username")) Then
        If Session("role") = "admin" Then
            Response.Redirect("page/admin/dashboard.aspx")
        ElseIf Session("role") = "user" Then
            Response.Redirect("page/user/pagination.aspx")
        End If
    End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Web Template</title>

    <link rel="icon" href="dist/img/logo.ico" type="image/x-icon" />
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="dist/css/font.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
</head>
<body class="hold-transition login-page">
  <div class="login-box">
    <div class="login-logo">
      <img src="dist/img/logo.png" style="height:150px;">
      <h2><b>Web<br>Template</b></h2>
    </div>
    <!-- /.login-logo -->
    <div class="card">
      <div class="card-body login-card-body">
        <p class="login-box-msg"><b>Sign in to start your session</b></p>

        <form action="" method="POST" id="login_form" runat="server">
          <div class="form-group">
            <div class="input-group">
              <input type="text" class="form-control" id="username" name="username" placeholder="Username" autocomplete="off" required>
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-user"></span>
                </div>
              </div>
            </div>
          </div>
          <div class="form-group">
            <div class="input-group">
              <input type="password" class="form-control" id="password" name="password" placeholder="Password" autocomplete="off" required>
              <div class="input-group-append">
                <div class="input-group-text">
                  <span class="fas fa-lock"></span>
                </div>
              </div>
            </div>
          </div>
          <div class="row mb-2">
            <div class="col">
              <button type="submit" class="btn bg-primary btn-block" name="Login" value="login">Login</button>
            </div>
          </div>
          <div class="row mb-2">
            <div class="col">
              <button type="button" href="#" target="_blank" class="btn bg-danger btn-block" id="wi">Work Instruction</button>
            </div>
          </div>
          <div class="row">
            <div class="col">
              <center>
                <a href="page/viewer/">Go Back to Home Page</a>
              </center>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>

<!-- jQuery -->
<script src="plugins/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>

</body>
</html>
