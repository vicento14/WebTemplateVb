Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.IO

Public Class Main
    Public Overloads Function CountAccountList(ByVal searchArr As Array, conn As SqlConnection) As String
        Dim total As Integer = 0

        Dim sql As String = "SELECT count(id) AS total FROM user_accounts"
        sql += " WHERE id_number LIKE '" & searchArr(0) & "%'"
        sql += " AND full_name LIKE '" & searchArr(1) & "%'"
        sql += " AND role LIKE '" & searchArr(2) & "%'"
        Dim cmd As New SqlCommand(sql, conn)

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                While reader.Read()
                    total = reader.Item("total").ToString()
                End While
            Else
                total = 0
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            total = "SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString()
        End Try

        Return total
    End Function

    Public Overloads Function CountAccountList(ByVal searchArr As String, conn As SqlConnection) As String
        Dim total As Integer = 0

        Dim sql As String = "SELECT count(id) AS total FROM user_accounts"
        sql += " WHERE id_number LIKE '" & searchArr & "%'"
        Dim cmd As New SqlCommand(sql, conn)

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                While reader.Read()
                    total = reader.Item("total").ToString()
                End While
            Else
                total = 0
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            total = "SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString()
        End Try

        Return total
    End Function

    Public Function CountTT1Data(conn As SqlConnection) As String
        Dim total As Integer = 0

        Dim sql As String = "SELECT count(id) AS total FROM t_t1"
        Dim cmd As New SqlCommand(sql, conn)

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                While reader.Read()
                    total = reader.Item("total").ToString()
                End While
            Else
                total = 0
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            total = "SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString()
        End Try

        Return total
    End Function

    Public Function CountTT2Data(ByVal searchArr As String, conn As SqlConnection) As String
        Dim total As Integer = 0

        Dim sql As String = "SELECT count(id) AS total FROM t_t2"
        sql += " WHERE c1 = '" & searchArr & "'"
        Dim cmd As New SqlCommand(sql, conn)

        Try
            conn.Open()

            Dim reader = cmd.ExecuteReader()

            If reader.HasRows Then
                While reader.Read()
                    total = reader.Item("total").ToString()
                End While
            Else
                total = 0
            End If

            reader.Close()
            conn.Close()

        Catch ex As Exception
            total = "SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString()
        End Try

        Return total
    End Function

    Public Function CountImportRows(ByVal fileName As String, Server As Object) As Integer
        Dim rowCount As Integer = -2
        Dim sr As New StreamReader(CStr(Server.MapPath("csv/" & fileName)), Encoding.UTF8)

        While Not sr.EndOfStream
            Dim line As String = sr.ReadLine()
            rowCount += 1
        End While

        sr.Close()

        Return rowCount
    End Function

    Public Function RemoveBomUtf8(ByVal firstLine As String) As String
        If firstLine.Substring(0, 3) = Chr(239).ToString() + Chr(187).ToString() + Chr(191).ToString() Then
            Return firstLine.Substring(3)
        Else
            Return firstLine
        End If
    End Function

    Public Function CheckCsv(ByVal fileName As String, Server As Object, conn As SqlConnection) As String
        ' READ FILE
        Dim sr As StreamReader = New StreamReader(CStr(Server.MapPath("csv/" & fileName)), Encoding.UTF8)
        ' SKIP FIRST LINE
        Dim firstLine = sr.ReadLine()
        ' Remove UTF-8 BOM from First Line
        firstLine = RemoveBomUtf8(firstLine)

        Dim hasError As Integer = 0
        Dim hasBlankError As Integer = 0
        Dim isExistsOnDb As Integer = 0
        Dim isDuplicateOnCsv As Integer = 0
        Dim hasBlankErrorArr As New ArrayList()
        Dim isExistsOnDbArr As New ArrayList()
        Dim isDuplicateOnCsvArr As New ArrayList()
        Dim dupTempArr As New HashSet(Of String)

        Dim message As String = ""
        Dim checkCsvRow As Integer = 0

        Dim oFileRowStr As Object, oFileRowArr As Object

        firstLine = Replace(firstLine, "/[\t\n\r]+/", "")
        Dim valid_first_line1 As String = """ID Number"",""Full Name"",Username,Password,Section,Role"
        Dim valid_first_line2 As String = "ID Number,Full Name,Username,Password,Section,Role"

        If firstLine = valid_first_line1 Or firstLine = valid_first_line2 Then
            Do While sr.Peek() >= 0
                checkCsvRow += 1

                oFileRowStr = String.Empty
                oFileRowStr = sr.ReadLine

                If String.IsNullOrEmpty(oFileRowStr.ToString()) Then
                    Continue Do
                End If

                oFileRowArr = Split(oFileRowStr, ",")

                Dim id_number As String = oFileRowArr(0)
                Dim full_name As String = oFileRowArr(1)
                Dim username As String = oFileRowArr(2)
                Dim password As String = oFileRowArr(3)
                Dim section As String = oFileRowArr(4)
                Dim role As String = oFileRowArr(5)

                ' CHECK IF BLANK DATA
                If id_number = "" Or full_name = "" Or username = "" Or password = "" Or section = "" Or role = "" Then
                    ' IF BLANK DETECTED ERROR += 1
                    hasBlankError += 1
                    hasError = 1
                    hasBlankErrorArr.Add(checkCsvRow)
                End If

                ' CHECK ROWS IF IT HAS DUPLICATE ON CSV
                If dupTempArr.Contains(oFileRowStr) Then
                    isDuplicateOnCsv = 1
                    hasError = 1
                    isDuplicateOnCsvArr.Add(checkCsvRow)
                Else
                    dupTempArr.Add(oFileRowStr)
                End If

                ' CHECK ROWS IF EXISTS
                Dim sql As String = "SELECT id FROM user_accounts"
                sql += " WHERE id_number = @id_number AND full_name = @full_name AND username = @username"
                sql += " AND section = @section AND role = @role"
                Dim cmd As New SqlCommand(sql, conn)
                With cmd
                    .Parameters.Clear()
                    .Parameters.AddWithValue("@id_number", id_number)
                    .Parameters.AddWithValue("@full_name", full_name)
                    .Parameters.AddWithValue("@username", username)
                    .Parameters.AddWithValue("@section", section)
                    .Parameters.AddWithValue("@role", role)
                End With

                Try
                    conn.Open()

                    Dim reader = cmd.ExecuteReader()

                    If reader.HasRows Then
                        isExistsOnDb = 1
                        hasError = 1
                        isExistsOnDbArr.Add(checkCsvRow)
                    End If

                    reader.Close()
                    conn.Close()

                Catch ex As Exception
                    message += "SYSTEM ERROR:\n" + ex.Message + "\n" + ex.ToString()
                End Try
            Loop
        Else
            message += "Invalid CSV Table Header. Maybe an incorrect CSV file Or incorrect CSV header "
        End If

        sr.Close()

        If hasError = 1 Then
            If isExistsOnDb = 1 Then
                message += "Data Already Recorded on row/s " + Join(isExistsOnDbArr.ToArray(), ",") + ". "
            End If
            If hasBlankError >= 1 Then
                message += "Blank Cell/s Exists on row/s " + Join(hasBlankErrorArr.ToArray(), ",") + ". "
            End If
            If isDuplicateOnCsv = 1 Then
                message += "Duplicated Record/s on row/s " + Join(isDuplicateOnCsvArr.ToArray(), ",") + ". "
            End If
        End If

        Return message
    End Function
End Class
