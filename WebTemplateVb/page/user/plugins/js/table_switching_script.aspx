<script type="text/javascript">
$( document ).ready(function() {
     load_t_t1();
});

const load_t_t1 = () =>{
    $.ajax({
        url:'../../process/user/table_switching/ts_p.aspx',
        type:'POST',
        cache:false,
        data:{
            method:'load_t_t1'
        },
        beforeSend: () => {
            var loading = `<tr id="loading"><td colspan="6" style="text-align:center;"><div class="spinner-border text-dark" role="status"><span class="sr-only">Loading...</span></div></td></tr>`;
            document.getElementById("t_table").innerHTML = loading;
        }, 
        success:function(response){
            $('#loading').remove();
            $('#t_table').html(response);
            $('#lbl_c1').html('');
            $('#t_t1_breadcrumb').hide();
        }
    });
}

const load_t_t2 = el =>{
    var c1 = el.dataset.c1;

    $.ajax({
        url:'../../process/user/table_switching/ts_p.aspx',
        type:'POST',
        cache:false,
        data:{
            method:'load_t_t2',
            c1:c1
        },
        beforeSend: () => {
            var loading = `<tr id="loading"><td colspan="6" style="text-align:center;"><div class="spinner-border text-dark" role="status"><span class="sr-only">Loading...</span></div></td></tr>`;
            document.getElementById("t_table").innerHTML = loading;
        }, 
        success:function(response){
            $('#loading').remove();
            $('#t_table').html(response);
            $('#lbl_c1').html(c1);
            $('#t_t1_breadcrumb').show();
        }
    });
}
</script>