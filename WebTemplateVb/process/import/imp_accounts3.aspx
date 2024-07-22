<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    'MS SQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    Dim startRow As Integer = 1
    Dim insertsql As String = "INSERT INTO user_accounts (id_number, full_name, username, password, section, role) VALUES"
    Dim subsql As String = ""
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
            Response.Write("File not found after saving to temp path, Try to upload file again")
        Else
            Try
                Dim MainClass As New Main
                Dim rowCount As Integer = MainClass.CountImportRows(fileName, Server)

                Dim chkCsvMsg As String = MainClass.CheckCsv(fileName, Server, conn)

                If chkCsvMsg = "" Then
                    Dim sr As StreamReader = New StreamReader(Server.MapPath("csv/" & fileName), Encoding.UTF8)

                    Dim tempCount As Integer = 0

                    'Skip First Line (Header)
                    sr.ReadLine()

                    Do While sr.Peek() >= 0
                        oFileRowStr = String.Empty
                        oFileRowStr = sr.ReadLine

                        If String.IsNullOrEmpty(oFileRowStr.ToString()) Then
                            tempCount += 1
                            Continue Do
                        End If

                        oFileRowArr = Split(oFileRowStr, ",")

                        subsql += " ("
                        tempCount += 1
                        startRow += 1

                        For Each row As String In oFileRowArr
                            subsql += "'" + row + "',"
                        Next

                        subsql = subsql.Substring(0, subsql.Length() - 2)
                        subsql += "'), "

                        If tempCount Mod 250 = 0 Then
                            subsql = subsql.Substring(0, subsql.Length() - 2)
                            insertsql += subsql + ";"
                            insertsql = insertsql.Substring(0, insertsql.Length())

                            'chkCsvMsg += insertsql

                            cmd = New SqlCommand(insertsql, conn)

                            conn.Open()

                            cmd.ExecuteNonQuery()
                            cmd.Dispose()

                            conn.Close()

                            insertsql = "INSERT INTO user_accounts (id_number, full_name, username, password, section, role) VALUES"
                            subsql = ""
                        ElseIf tempCount = rowCount Then
                            subsql = subsql.Substring(0, subsql.Length() - 2)
                            Dim insertsql2 As String = insertsql + subsql + ";"
                            insertsql2 = insertsql2.Substring(0, insertsql2.Length())

                            'chkCsvMsg += insertsql2

                            cmd = New SqlCommand(insertsql2, conn)

                            conn.Open()

                            cmd.ExecuteNonQuery()
                            cmd.Dispose()

                            conn.Close()
                        End If
                    Loop

                    sr.Close()

                    'Response.Write(chkCsvMsg)
                    'success
                Else
                    Response.Write(chkCsvMsg)
                End If

            Catch ex As Exception
                Response.Write("SYSTEM ERROR: " + ex.Message + " " + ex.ToString())
            End Try

            'Success
        End If
    Else
        Response.Write("Failed to get filename. Please upload file")
    End If

    hpf = Nothing
    hfc = Nothing
%>