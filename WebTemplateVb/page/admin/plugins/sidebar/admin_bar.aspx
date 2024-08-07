<%@ Import Namespace="System.Web" %>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="dashboard.aspx" class="brand-link">
        <img src="../../dist/img/logo.ico" alt="Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">&ensp;WEB &ensp;|&ensp; Admin</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <img src="../../dist/img/user.png" class="img-circle elevation-2" alt="User Image">
            </div>
            <div class="info">
                <a href="dashboard.aspx" class="d-block"><%=HttpUtility.HtmlEncode(Session("name"))%></a>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Add icons to the links using the .nav-icon class
             with font-awesome or any other icon font library -->
                <li class="nav-item">
                    <a href="dashboard.aspx" class="<%= If(HttpContext.Current.Request.Url.AbsolutePath.EndsWith("dashboard.aspx"), "nav-link active", "nav-link") %>">
                        <i class="nav-icon fas fa-bus"></i>
                        <p>
                            Dashboard
                        </p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="accounts.aspx" class="<%= If(HttpContext.Current.Request.Url.AbsolutePath.EndsWith("accounts.aspx"), "nav-link active", "nav-link") %>">
                        <i class="nav-icon fas fa-user-cog"></i>
                        <p>
                            Account Management
                        </p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="sample1.aspx" class="<%= If(HttpContext.Current.Request.Url.AbsolutePath.EndsWith("sample1.aspx"), "nav-link active", "nav-link") %>">
                        <i class="nav-icon fas fa-user-cog"></i>
                        <p>
                            Sample 1
                        </p>
                    </a>
                </li>
                <!--#include file ="logout.aspx"-->
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>
