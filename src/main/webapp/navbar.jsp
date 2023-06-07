<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" />
 
    <!-- Bootstrap Font Icon CSS -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" />
<!-- custom css -->
<link rel="stylesheet" href="./css/stylesheet.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light border-success " style="border-bottom:2px solid ">
  <div class="container-fluid">
    <a class="navbar-brand text-success" href="#" ><strong>RADHA KRISHNA </strong></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
  		 <core:if test="${sessionScope.is_admin}">
  		 <li class="nav-item">
          <a class="nav-link btn-sm" href="adminPanel.jsp"><i class="fa-solid fa-user-gear"></i> Admin Panel</a>
        </li>
        
  		
       
        <li class="nav-item">
          <a class="nav-link" href="addOperatorForm.jsp"><i class="bi bi-person-plus"></i> Add Operator</a>
        </li>
        
       <!--   <li class="nav-item">
          <a class="nav-link" href="#"><svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-person-gear" viewBox="0 0 16 16">
  				<path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0ZM8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4Zm.256 7a4.474 4.474 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10c.26 0 .507.009.74.025.226-.341.496-.65.804-.918C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4s1 1 1 1h5.256Zm3.63-4.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382l.045-.148ZM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0Z"/>
					</svg> Add Admin
		</a>
        </li>-->
       </core:if>
        <core:if test="${sessionScope.loggedIn}">
         <li class="nav-item">
          <a class="nav-link" href="addProductInStock.jsp"><i class="bi bi-cart-plus"></i> Add Product</a>
        </li>
        
         
        <li class="nav-item">
          <a class="nav-link" href="allBillings.jsp"><i class="bi bi-shop"></i> Add Stock Room</a>
        </li>
        
        <li class="nav-item ">
          <a class="nav-link" href="addBillings.jsp"><i class="bi bi-journal-plus"></i> Add Billings</a>
        </li>
        
         <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-person-fill-gear" viewBox="0 0 16 16">
  <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm-9 8c0 1 1 1 1 1h5.256A4.493 4.493 0 0 1 8 12.5a4.49 4.49 0 0 1 1.544-3.393C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4Zm9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382l.045-.148ZM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0Z"/>
</svg> Account
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
          	<li><button class="dropdown-item" ><i class="bi bi-person-lines-fill"></i> ${sessionScope.id}</button></li> 
            <li><a class="dropdown-item" href="updatePasswordForm.jsp?id=${sessionScope.id}&name=${sessionScope.name}"><i class="bi bi-key"></i> Change Password</a></li>
            <li><a class="dropdown-item" href="logout"><i class="bi bi-box-arrow-left"></i> Logout</a></li>            
          </ul>
        </li>
        </core:if>
      </ul>
      <core:if test="${sessionScope.loggedIn}">
      <form action="billingSearchResult.jsp" class="d-flex col-2" style="position:absolute;right:150px">
        <input class="form-control me-2 col-4" type="search" placeholder="Search Billings..." aria-label="Search" name="searchBillingsFor" required>
        <button class="btn btn-sm  btn-success col-2" type="submit"  title="Click to Search"><i class="bi bi-search"></i> </button>
      </form>
      </core:if>
    </div>
  </div>
</nav>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>