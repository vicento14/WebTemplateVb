<aside class="main-sidebar sidebar-dark-primary elevation-4">
  <!-- Brand Logo -->
  <a href="pagination.aspx" class="brand-link">
    <img src="../../dist/img/logo.ico" alt="Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
    <span class="brand-text font-weight-light">&ensp;WEB &ensp;|&ensp; <%=HttpUtility.HtmlEncode(Session("section"))%></span>
  </a>

  <!-- Sidebar -->
  <div class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
      <div class="image">
        <img src="../../dist/img/user.png" class="img-circle elevation-2" alt="User Image">
      </div>
      <div class="info">
        <a href="pagination.aspx" class="d-block"><%=HttpUtility.HtmlEncode(Session("name"))%></a>
      </div>
    </div>

    <!-- Sidebar Menu -->
    <nav class="mt-2">
      <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        <!-- Add icons to the links using the .nav-icon class
             with font-awesome or any other icon font library -->
        <li class="nav-item">
          <a href="pagination.aspx" class="nav-link">
            <i class="nav-icon far fa-file-alt"></i>
            <p>
              Pagination
            </p>
          </a>
        </li> 
        <li class="nav-item">
          <a href="load_more.aspx" class="nav-link">
            <i class="nav-icon far fa-file-alt"></i>
            <p>
              Load More
            </p>
          </a>
        </li> 
        <li class="nav-item">
          <a href="table_switching.aspx" class="nav-link">
            <i class="nav-icon far fa-file-alt"></i>
            <p>
              Table Switching
            </p>
          </a>
        </li> 
        <li class="nav-item">
          <a href="keyup_search.aspx" class="nav-link active">
            <i class="nav-icon far fa-file-alt"></i>
            <p>
              Keyup Search
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