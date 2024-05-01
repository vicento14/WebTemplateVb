Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

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
End Class
