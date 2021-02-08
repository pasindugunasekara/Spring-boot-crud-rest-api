<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Custmer list</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">


</head>
<body onload="loadAllCustomers()">


    <nav class="navbar navbar-light bg-light">
        <span class="navbar-brand mb-0 h1">Customer Form</span>
    </nav>

    <section class="container-fluid">
        <div class="row">
        <div align="center" class="col-md-6 mt-5">
            <form id="customerForm">
                <div class="form-group">
                    <label for="customerID">ID</label>
                    <input class="form-control" id="customerID" name="id" type="text" placeholder="Ex : C001">
                </div>
                <div class="form-group">
                    <label for="customerName">Name</label>
                    <input class="form-control" id="customerName" name="name" type="text" placeholder="Ex : Gunasekara">
                </div>
                <div class="form-group">
                    <label for="customerAddress">Address</label>
                    <input class="form-control" id="customerAddress" name="address" type="text" placeholder="Ex : No 1 Galle">
                </div>
                <div class="form-group">
                    <label for="customerContact">Contact</label>
                    <input class="form-control" id="customerContact" name="contact" type="text" placeholder="Ex : 0915714116">
                </div>
                <div >
                    <button class="btn btn-primary" id="Save" type="button">Save Customer</button>
                    <button class="btn btn-success" id="Update" type="button">Update</button>
                    <button class="btn btn-danger" id="Delete" type="button">Delete</button>
                </div>
            </form>
        </div>
            <div align="center" class="col-md-6 mt-3">
                <h1>Table</h1>
                <table align="center"  class="table table-bordered border-primary">
                    <thead class="table-dark">
                    <tr class="table-active">
                        <th>ID</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>CONTACT</th>
                    </tr>
                    </thead>
                    <tbody id="tblCustomer">

                    </tbody>
                </table>




            </div>
        </div>
    </section>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>


<script>

    // DONE
    $("#Save").click(function () {
        let id = $("#customerID").val();
        let name = $("#customerName").val();
        let address = $("#customerAddress").val();
        let contact = $("#customerContact").val();

        $.ajax({
            method: "post",
            url: "http://localhost:8080/api/v1/customer",
            contentType: "application/json",
            data: JSON.stringify({
                "id": id,
                "name": name,
                "address": address,
                "contact" : contact
            }),
            success: function (res) {
                if (res.message == "Successefully added") {
                    alert("Customer Added that you input");
                } else {
                    alert(res.data);
                }
                loadAllCustomers();
            }
        });
    });

    // DONE
    $("#Delete").click(function (){
        let customerID=$("#customerID").val();
        $.ajax({
            method:"delete",
            url: "http://localhost:8080/api/v1/customer?id="+customerID,
            success:function (res){
                if (res.message == "Successfully deleted") {
                    alert("Customer Removed from DB..!");
                } else {
                    alert(res.data);
                }
                loadAllCustomers();
            }
        });
    });


    $("#Clear").click(function () {
        loadAllCustomers();
    });

    loadAllCustomers();





    //DONE
    $("#customerID").on('keypress', function (e) {
        if (e.code == "Enter") {
            let customerID = $("#customerID").val();
            $.ajax({
                url: "http://localhost:8080/api/v1/customer/" + customerID,
                success: function (res) {
                    console.log(res);
                    let customer = res.data;
                    $("#customerID").val(customer.id);
                    $("#customerName").val(customer.name);
                    $("#customerAddress").val(customer.address);
                    $("#customerContact").val(customer.contact);
                }
            });
        }
    });


    // DONE
    $("#Update").click(function () {
        let id = $("#customerID").val();
        let name = $("#customerName").val();
        let address = $("#customerAddress").val();
        let contact = $("#customerContact").val();

        $.ajax({
            method: "put",
            url: "http://localhost:8080/api/v1/customer",
            contentType: "application/json",
            data: JSON.stringify({
                "id": id,
                "name": name,
                "address": address,
                "contact": contact
            }),
            success: function (res) {
                if (res.message == "Success") {
                    alert("Customer Updated");
                } else {
                    alert(res.data);
                }
                loadAllCustomers();
            }
        });
    });


    function loadAllCustomers() {
        $("#tblCustomer").empty();
        $.ajax({
            url: "http://localhost:8080/api/v1/customer/list",
            dataType: 'json',
            success: function (res) {
                let data = res.data;
                for (var i  in data) {
                    let id = data[i].id;
                    let name = data[i].name;
                    let address = data[i].address;
                    let contact = data[i].contact;
                    var row = "<tr>" +
                                "<td>" +id +"</td>"+
                                "<td>" + name+ "</td>"+
                                "<td> "+address+ "</td>"+
                                "<td>"+contact+"</td>" +
                            "</tr>";
                    $("#tblCustomer").append(row);
                    console.log(data);
                }
            }
        });
    }


</script>
</body>
</html>