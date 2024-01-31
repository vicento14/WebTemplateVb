<%@ Page Language="VB" AutoEventWireup="false" CodeFile="exp_accounts.aspx.vb" Inherits="process_export_exp_accounts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <%@ Import Namespace="System.Collections.Generic" %>
    <%@ Import Namespace="System.IO" %>
    <%@ Import Namespace="System.Data" %>
    <%@ Import Namespace="System.Data.SqlClient" %>

    <%
        'MS SQL Connection
        Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
        Dim conn As SqlConnection = New SqlConnection(conn_str)

        Dim employee_no As String = Request.QueryString("employee_no")
        Dim full_name As String = Request.QueryString("full_name")

        Dim c As Integer = 0

        Dim fs, tfile
        fs = Server.CreateObject("Scripting.FileSystemObject")
        tfile = fs.CreateTextFile("C:\Users\Asus_X455L\source\repos\WebTemplateVb\WebTemplateVb\process\export\csv\Export-Accounts.csv", True)

        'Dim header As New List(Of String)
        'header.Add("#")
        'header.Add("ID Number")
        'header.Add("Full Name")
        'header.Add("Username")
        'header.Add("Password")
        'header.Add("Section")
        'header.Add("Role")

        'tfile.WriteLine(Strings.Join(Header.ToArray, ","))
        tfile.Write("#,ID Number,Full Name,Username,Password,Section,Role" & vbCrLf)

        Dim sql As String = "SELECT id_number, full_name, username, password, section, role FROM user_accounts"
        sql += " WHERE id_number LIKE '" & employee_no & "%'"
        sql += " AND full_name LIKE '" & full_name & "%'"
        Dim cmd As New SqlCommand(sql, conn)

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                While reader.Read()
                    c += 1

                    Dim list As New List(Of String)
                    list.Add(c.ToString())
                    list.Add(reader.Item("id_number").ToString())
                    list.Add(String.Format("""{0}""", reader.Item("full_name").ToString()))
                    list.Add(reader.Item("username").ToString())
                    list.Add(reader.Item("password").ToString())
                    list.Add(reader.Item("section").ToString())
                    list.Add(reader.Item("role").ToString())

                    'Dim arrResult(6) As String
                    'arrResult(0) = c.ToString()
                    'arrResult(1) = reader.Item("id_number").ToString()
                    'arrResult(2) = String.Format("""{0}""", reader.Item("full_name").ToString())
                    'arrResult(3) = reader.Item("username").ToString()
                    'arrResult(4) = reader.Item("password").ToString()
                    'arrResult(5) = reader.Item("section").ToString()
                    'arrResult(6) = reader.Item("role").ToString()

                    tfile.WriteLine(Strings.Join(list.ToArray, ","))
                    'tfile.WriteLine(Strings.Join(arrResult, ","))
                    'tfile.WriteLine(ControlChars.Quote & String.Join(ControlChars.Quote & "," & ControlChars.Quote, arrResult) & ControlChars.Quote)
                End While
            Else
                Dim noResult As New List(Of String)
                noResult.Add("No Result !!!")
                tfile.WriteLine(Strings.Join(noResult.ToArray, ","))
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            Dim exResult As New List(Of String)
            exResult.Add("SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString())
            tfile.WriteLine(Strings.Join(exResult.ToArray, ","))
        End Try

        tfile.close()
        tfile = Nothing
        fs = Nothing
    %>
    <script>
        window.open("csv/Export-Accounts.csv");
        window.close();
    </script>
</body>
</html>
