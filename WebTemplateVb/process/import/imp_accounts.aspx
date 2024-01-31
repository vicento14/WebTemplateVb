<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    'MS SQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    If Not String.IsNullOrEmpty(Request.Form("download_template")) Then
        Response.Redirect("../../template/accounts_template.csv")
    End If

    If Not String.IsNullOrEmpty(Request.Form("upload")) Then
        Dim sql As String
        Dim cmd As SqlCommand

        'Dim fs, oFile
        Dim oFileRowStr, oFileRowArr

        Dim hfc As HttpFileCollection = Request.Files
        Dim fileName As String = hfc(0).FileName
        Dim hpf As HttpPostedFile = hfc(0)

        If fileName <> "" Then
            hpf.SaveAs(Server.MapPath("csv/" & fileName))

            ' Using StreamReader (UTF-8 Enabled)

            Dim fi As New IO.FileInfo(Server.MapPath("csv/" & fileName))

            If Not fi.Exists Then
                Response.Write("<script>alert('Error: File not found after saving to temp path, Try to upload file again')</script>")
            Else
                Try
                    Dim sr As StreamReader = New StreamReader(Server.MapPath("csv/" & fileName), Encoding.UTF8)

                    'Skip First Line (Header)
                    sr.ReadLine()

                    Do While sr.Peek() >= 0
                        oFileRowStr = String.Empty
                        oFileRowStr = sr.ReadLine
                        oFileRowArr = Split(oFileRowStr, ",")

                        sql = "INSERT INTO user_accounts (id_number, full_name, username, password, section, role)"
                        sql += " VALUES (@id_number,@full_name,@username,@password,@section,@role)"
                        cmd = New SqlCommand(sql, conn)
                        With cmd
                            .Parameters.Clear()
                            .Parameters.AddWithValue("@id_number", oFileRowArr(0))
                            .Parameters.AddWithValue("@full_name", oFileRowArr(1))
                            .Parameters.AddWithValue("@username", oFileRowArr(2))
                            .Parameters.AddWithValue("@password", oFileRowArr(3))
                            .Parameters.AddWithValue("@section", oFileRowArr(4))
                            .Parameters.AddWithValue("@role", oFileRowArr(5))
                        End With

                        conn.Open()

                        cmd.ExecuteNonQuery()
                        cmd.Dispose()

                        conn.Close()
                    Loop

                Catch ex As Exception
                    Response.Write("<script>alert('SYSTEM ERROR: " + ex.Message + " " + ex.ToString() + "')</script>")
                End Try

                Response.Write("<script>alert('Success')</script>")
            End If

            ' Using FileSystemObject (ANSI Only)

            'fs = Server.CreateObject("Scripting.FileSystemObject")

            'If Not fs.FileExists(Server.MapPath("csv/" & fileName)) Then
            '    Response.Write("<script>alert('Error: File not found after saving to temp path, Try to upload file again')</script>")
            'Else
            '    oFile = fs.OpenTextFile(Server.MapPath("csv/" & fileName), 1, False)

            '    Do Until oFile.AtEndOfStream
            '        oFileRowStr = oFile.readLine
            '        oFileRowArr = Split(oFileRowStr, ",")

            '        sql = "INSERT INTO user_accounts (id_number, full_name, username, password, section, role)"
            '        sql += " VALUES (@id_number,@full_name,@username,@password,@section,@role)"
            '        cmd = New SqlCommand(sql, conn)
            '        With cmd
            '            .Parameters.Clear()
            '            .Parameters.AddWithValue("@id_number", oFileRowArr(0))
            '            .Parameters.AddWithValue("@full_name", oFileRowArr(1))
            '            .Parameters.AddWithValue("@username", oFileRowArr(2))
            '            .Parameters.AddWithValue("@password", oFileRowArr(3))
            '            .Parameters.AddWithValue("@section", oFileRowArr(4))
            '            .Parameters.AddWithValue("@role", oFileRowArr(5))
            '        End With

            '        Try
            '            conn.Open()

            '            cmd.ExecuteNonQuery()
            '            cmd.Dispose()

            '            conn.Close()

            '        Catch ex As Exception
            '            Response.Write("<script>alert('SYSTEM ERROR: " + ex.Message + " " + ex.ToString() + "')</script>")
            '        End Try
            '    Loop

            '    oFile.Close()
            '    oFile = Nothing
            '    fs = Nothing

            '    Response.Write("<script>alert('Success')</script>")
            'End If
        Else
            Response.Write("<script>alert('Error: Failed to get filename. Please upload file')</script>")
        End If

        hpf = Nothing
        hfc = Nothing

        Response.Write("<script>window.location.href = '../../page/admin/accounts.aspx'</script>")
    End If
%>