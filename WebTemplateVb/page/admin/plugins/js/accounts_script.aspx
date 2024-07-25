<script type="text/javascript">
    // DOMContentLoaded function
    document.addEventListener("DOMContentLoaded", () => {
        load_accounts();
        load_accounts2();
    });

    const load_accounts = () => {
        $.ajax({
            url: '../../process/admin/accounts/acct-management_p.aspx',
            type: 'POST',
            cache: false,
            data: {
                method: 'account_list'
            }, success: function (response) {
                document.getElementById("list_of_accounts").innerHTML = response;
            }
        });
    }

    // JQUERY AJAX Load
    const load_accounts2 = () => {
        $("#list_of_accounts2").load("../../process/admin/accounts/acct-management_p.aspx", { method: 'account_list' });
    }

    const search_accounts = () => {
        var employee_no = document.getElementById('employee_no_search').value;
        var full_name = document.getElementById('full_name_search').value;
        var user_type = document.getElementById('user_type_search').value;
        $.ajax({
            url: '../../process/admin/accounts/acct-management_p.aspx',
            type: 'POST',
            cache: false,
            data: {
                method: 'search_account_list',
                employee_no: employee_no,
                full_name: full_name,
                user_type: user_type
            }, success: function (response) {
                document.getElementById("list_of_accounts").innerHTML = response;
            }
        });
    }

    document.getElementById('new_account_form').addEventListener('submit', e => {
        e.preventDefault();
        register_accounts();
    });

    const register_accounts = () => {
        var employee_no = document.getElementById('employee_no').value;
        var full_name = document.getElementById('full_name').value;
        var username = document.getElementById('username').value;
        var password = document.getElementById('password').value;
        var section = document.getElementById('section').value;
        var user_type = document.getElementById('user_type').value;

        $.ajax({
            url: '../../process/admin/accounts/acct-management_p.aspx',
            type: 'POST',
            cache: false,
            data: {
                method: 'register_account',
                employee_no: employee_no,
                full_name: full_name,
                username: username,
                password: password,
                section: section,
                user_type: user_type
            }, success: function (response) {
                if (response == 'success') {
                    Swal.fire({
                        icon: 'success',
                        title: 'Succesfully Recorded!!!',
                        text: 'Success',
                        showConfirmButton: false,
                        timer: 1000
                    });
                    document.getElementById("employee_no").value = '';
                    document.getElementById("full_name").value = '';
                    document.getElementById("username").value = '';
                    document.getElementById("password").value = '';
                    document.getElementById("section").value = '';
                    document.getElementById("user_type").value = '';
                    load_accounts();
                    load_accounts2();
                    $('#new_account').modal('hide');
                } else if (response == 'Already Exist') {
                    Swal.fire({
                        icon: 'info',
                        title: 'Duplicate Data !!!',
                        text: 'Information',
                        showConfirmButton: false,
                        timer: 2000
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error !!!',
                        text: response,
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            }
        });
    }

    const get_accounts_details = el => {
        var id = el.dataset.id;
        var id_number = el.dataset.id_number;
        var username = el.dataset.username;
        var full_name = el.dataset.full_name;
        var password = el.dataset.password;
        var section = el.dataset.section;
        var role = el.dataset.role;

        document.getElementById('id_account_update').value = id;
        document.getElementById('employee_no_update').value = id_number;
        document.getElementById('username_update').value = username;
        document.getElementById('full_name_update').value = full_name;
        document.getElementById('password_update').value = password;
        document.getElementById('section_update').value = section;
        document.getElementById('user_type_update').value = role;
    }

    // Get the form element
    var update_account_form = document.getElementById('update_account_form');

    // Add a submit event listener to the form
    update_account_form.addEventListener('submit', e => {
        e.preventDefault();

        // Get the button that triggered the submit event
        var button = document.activeElement;

        // Check the id or name of the button
        if (button.id === 'btnUpdateAccount') {
            // Call the function for the first submit button
            update_account();
        } else if (button.id === 'btnDeleteAccount') {
            // Call the function for the first submit button
            delete_account();
        }
    });

    const update_account = () => {
        var id = document.getElementById('id_account_update').value;
        var id_number = document.getElementById('employee_no_update').value;
        var username = document.getElementById('username_update').value;
        var full_name = document.getElementById('full_name_update').value;
        var password = document.getElementById('password_update').value;
        var section = document.getElementById('section_update').value;
        var role = document.getElementById('user_type_update').value;

        $.ajax({
            url: '../../process/admin/accounts/acct-management_p.aspx',
            type: 'POST',
            cache: false,
            data: {
                method: 'update_account',
                id: id,
                id_number: id_number,
                username: username,
                full_name: full_name,
                password: password,
                section: section,
                role: role
            }, success: function (response) {
                if (response == 'success') {
                    Swal.fire({
                        icon: 'success',
                        title: 'Succesfully Recorded!!!',
                        text: 'Success',
                        showConfirmButton: false,
                        timer: 1000
                    });
                    document.getElementById("employee_no_update").value = '';
                    document.getElementById("full_name_update").value = '';
                    document.getElementById("username_update").value = '';
                    document.getElementById("password_update").value = '';
                    document.getElementById("section_update").value = '';
                    document.getElementById("user_type_update").value = '';
                    load_accounts();
                    load_accounts2();
                    $('#update_account').modal('hide');
                } else if (response == 'duplicate') {
                    Swal.fire({
                        icon: 'info',
                        title: 'Duplicate Data !!!',
                        text: 'Information',
                        showConfirmButton: false,
                        timer: 2000
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error !!!',
                        text: 'Error',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            }
        });
    }

    const delete_account = () => {
        var id = document.getElementById('id_account_update').value;
        $.ajax({
            url: '../../process/admin/accounts/acct-management_p.aspx',
            type: 'POST',
            cache: false,
            data: {
                method: 'delete_account',
                id: id
            }, success: function (response) {
                if (response == 'success') {
                    Swal.fire({
                        icon: 'info',
                        title: 'Succesfully Deleted !!!',
                        text: 'Information',
                        showConfirmButton: false,
                        timer: 1000
                    });
                    document.getElementById("employee_no_update").value = '';
                    document.getElementById("full_name_update").value = '';
                    document.getElementById("username_update").value = '';
                    document.getElementById("password_update").value = '';
                    document.getElementById("section_update").value = '';
                    document.getElementById("user_type_update").value = '';
                    load_accounts();
                    load_accounts2();
                    $('#update_account').modal('hide');
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error !!!',
                        text: 'Error',
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            }
        });
    }

    const export_employees = () => {
        var employee_no = document.getElementById('employee_no_search').value;
        var full_name = document.getElementById('full_name_search').value;
        window.open('../../process/export/exp_accounts_test.aspx?employee_no=' + employee_no + "&full_name=" + full_name, '_blank');
    }

    const export_employees3 = () => {
        var employee_no = document.getElementById('employee_no_search').value;
        var full_name = document.getElementById('full_name_search').value;
        window.open('../../process/export/exp_accounts_test.aspx?employee_no=' + employee_no + "&full_name=" + full_name, '_blank');
    }

    // Export CSV
    document.getElementById("export_csv").addEventListener("click", e => {
        e.preventDefault();
        let table_id = "accounts_table";
        let filename = 'Export-Accounts' + '_' + new Date().toLocaleDateString() + '.csv';
        export_csv(table_id, filename);
    });

    const upload_csv = () => {
        var file_form = document.getElementById('file_form');
        var form_data = new FormData(file_form);
        $.ajax({
            url: '../../process/import/imp_accounts2.aspx',
            type: 'POST',
            dataType: 'text',
            cache: false,
            contentType: false,
            processData: false,
            data: form_data,
            beforeSend: (jqXHR, settings) => {
                Swal.fire({
                    icon: 'info',
                    title: 'Uploading Please Wait...',
                    text: 'Info',
                    showConfirmButton: false,
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    allowEnterKey: false
                });
                jqXHR.url = settings.url;
                jqXHR.type = settings.type;
            },
            success: response => {
                setTimeout(() => {
                    swal.close();
                    if (response != '') {
                        Swal.fire({
                            icon: 'error',
                            title: 'Upload CSV Error',
                            text: `Error: ${response}`,
                            showConfirmButton: false,
                            timer: 1000
                        });
                    } else {
                        Swal.fire({
                            icon: 'info',
                            title: 'Upload CSV',
                            text: 'Uploaded and updated successfully',
                            showConfirmButton: false,
                            timer: 1000
                        });
                        document.getElementById("file2").value = '';
                        load_accounts();
                        load_accounts2();
                    }
                }, 500);
            }
        })
            .fail((jqXHR, textStatus, errorThrown) => {
                console.log(jqXHR);
                swal('System Error', `Call IT Personnel Immediately!!! They will fix it right away. Error: url: ${jqXHR.url}, method: ${jqXHR.type} ( HTTP ${jqXHR.status} - ${jqXHR.statusText} ) Press F12 to see Console Log for more info.`, 'error');
            });
    }

    const popup1 = () => {
        var employee_no = document.getElementById('employee_no_search').value;
        var full_name = document.getElementById('full_name_search').value;
        PopupCenter('../../process/export/exp_accounts_test.aspx?employee_no=' + employee_no + '&full_name=' + full_name, 'Popup Export Accounts 3', '1190', '600');
    }
</script>
