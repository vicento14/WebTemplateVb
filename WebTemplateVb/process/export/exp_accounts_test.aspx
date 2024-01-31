
<%@ Import Namespace="System.Data.SqlClient" %>

<%
    'MS SQL Connection
    Dim conn_str As String = ConfigurationManager.ConnectionStrings("MsSqlSvrConnection2").ToString
    Dim conn As SqlConnection = New SqlConnection(conn_str)

    Dim employee_no As String = Request.QueryString("employee_no")
    Dim full_name As String = Request.QueryString("full_name")

    Dim c As Integer = 0
    Dim csv As New StringBuilder

    csv.AppendLine("#,ID Number,Full Name,Username,Password,Section,Role")

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

                Dim csv_row As New StringBuilder

                csv_row.Append(c.ToString().Replace(",", "") + ",")
                csv_row.Append(reader.Item("id_number").ToString().Replace(",", "") + ",")
                csv_row.Append(String.Format("""{0}"",", reader.Item("full_name").ToString()))
                csv_row.Append(reader.Item("username").ToString().Replace(",", "") + ",")
                csv_row.Append(reader.Item("password").ToString().Replace(",", "") + ",")
                csv_row.Append(reader.Item("section").ToString().Replace(",", "") + ",")
                csv_row.Append(reader.Item("role").ToString().Replace(",", ""))

                csv.AppendLine(csv_row.ToString)
            End While
        Else
            csv.AppendLine("No Result !!!")
        End If

        reader.Close()
        conn.Close()

    Catch ex As Exception
        csv.AppendLine("SYSTEM ERROR: " + ex.Message + " " + ex.ToString())
    End Try

    Response.Clear()
    Response.Buffer = True
    Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", "Export-Accounts.csv"))
    'Response.Charset = "utf-8"
    'Response.Charset = Encoding.UTF8.WebName
    Response.ContentType = "text/csv;charset=utf-8"
    '"{0xEF, 0xBB, 0xBF}
    '"\xEF\xBB\xBF"
    'Response.Write(ChrW(&HEF) & ChrW(&HBB) & ChrW(&HBF) & csv.ToString)
    Response.Write(ChrW(65279) & csv.ToString)
    Response.Flush()
    Response.End()
%>