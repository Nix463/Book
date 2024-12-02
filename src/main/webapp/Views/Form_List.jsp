<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%
String sdt = (String) session.getAttribute("SDT");
if (sdt == null) {
	response.sendRedirect("Views/Form_Login.jsp"); // Chuyển về đăng nhập nếu chưa đăng nhập
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DreamBooks</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style>
#suggestionsList {
    display: none;
    position: absolute;
    background-color: white;
    border: 1px solid #ccc;
    z-index: 1000;
    width: 100%;
}
#suggestionsList li {
    list-style: none;
    padding: 8px;
    cursor: pointer;
}
#suggestionsList li:hover {
    background-color: #f0f0f0;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-tertiary sticky-top">
		<div class="container-fluid">
			<a class="btn" onclick="home()" style="font-size: 24px;"><b>DreamBooks</b></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="#">Sách
							tiếng Việt</a></li>
					<li class="nav-item"><a class="nav-link" href="#">English
							Books</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Sách giáo
							khoa </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#">Tiểu học</a></li>
							<li><a class="dropdown-item" href="#">THCS</a></li>
							<li><a class="dropdown-item" href="#">THPT</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">Đại học</a></li>
						</ul></li>
					<div class="nav-item" style="position: relative;">
						<input class="form-control me-2" type="search" id="searchInput"
							placeholder="Tìm kiếm sản phẩm" aria-label="Search"
							value="${search != null && search != '' ? search : ''}">
						<ul id="suggestionsList"></ul>
					</div>
				</ul>
				<form class="d-flex">
					<a class="btn" onclick="FormCart('${SDT}', '${pass}')"> <svg
							xmlns="http://www.w3.org/2000/svg" fill="#737373"
							viewBox="0 0 24 24" width="24px" height="24px">    <path
								d="M 4.4140625 1.9960938 L 1.0039062 2.0136719 L 1.0136719 4.0136719 L 3.0839844 4.0039062 L 6.3789062 11.908203 L 5.1816406 13.824219 C 4.7816406 14.464219 4.7609531 15.272641 5.1269531 15.931641 C 5.4929531 16.590641 6.1874063 17 6.9414062 17 L 19 17 L 19 15 L 6.9414062 15 L 6.8769531 14.882812 L 8.0527344 13 L 15.521484 13 C 16.248484 13 16.917531 12.604703 17.269531 11.970703 L 20.873047 5.4863281 C 21.046047 5.1763281 21.041328 4.7981875 20.861328 4.4921875 C 20.681328 4.1871875 20.352047 4 19.998047 4 L 5.25 4 L 4.4140625 1.9960938 z M 6.0820312 6 L 18.298828 6 L 15.521484 11 L 8.1660156 11 L 6.0820312 6 z M 7 18 A 2 2 0 0 0 5 20 A 2 2 0 0 0 7 22 A 2 2 0 0 0 9 20 A 2 2 0 0 0 7 18 z M 17 18 A 2 2 0 0 0 15 20 A 2 2 0 0 0 17 22 A 2 2 0 0 0 19 20 A 2 2 0 0 0 17 18 z" /></svg>
						<p class="fw-light m-0">Giỏ hàng</p>
					</a> <a class="btn" href="#"> <svg
							xmlns="http://www.w3.org/2000/svg" fill="#737373"
							viewBox="0 0 24 24" width="24px" height="24px">
							<path
								d="M 12 3 C 9.8027056 3 8 4.8027056 8 7 C 8 9.1972944 9.8027056 11 12 11 C 14.197294 11 16 9.1972944 16 7 C 16 4.8027056 14.197294 3 12 3 z M 12 5 C 13.116414 5 14 5.8835859 14 7 C 14 8.1164141 13.116414 9 12 9 C 10.883586 9 10 8.1164141 10 7 C 10 5.8835859 10.883586 5 12 5 z M 12 14 C 10.255047 14 8.1871638 14.409783 6.4492188 15.095703 C 5.5802462 15.438663 4.7946961 15.84605 4.1660156 16.369141 C 3.5373351 16.892231 3 17.599384 3 18.5 L 3 21 L 21 21 L 21 20 L 21 18.5 C 21 17.599384 20.462665 16.892231 19.833984 16.369141 C 19.205304 15.84605 18.419754 15.438663 17.550781 15.095703 C 15.812836 14.409783 13.744953 14 12 14 z M 12 16 C 13.414047 16 15.346055 16.373999 16.818359 16.955078 C 17.554512 17.245618 18.176961 17.591965 18.554688 17.90625 C 18.932412 18.220535 19 18.434616 19 18.5 L 19 19 L 5 19 L 5 18.5 C 5 18.434616 5.0675867 18.220535 5.4453125 17.90625 C 5.8230383 17.591965 6.4454882 17.245618 7.1816406 16.955078 C 8.6539455 16.373999 10.585953 16 12 16 z" /></svg>
						<p class="fw-light m-0">Tài khoản</p>
					</a>
				</form>
			</div>
		</div>
	</nav>
	<div class="row p-3">
		<div class="col-sm-2 border rounded p-3 mx-auto">
			<div class="container">
				<!-- Thể loại sách -->
				<h6 class="mt-3 mb-2">THỂ LOẠI SÁCH</h6>
				<c:forEach var="category" items="${uniqueCategories}">
					<div class="form-check">
						<input type="radio" class="form-check-input" name="category"
							id="category-${category}" value="${category}"
							${theLoai == category ? 'checked' : ''} onclick="filterResults()">
						<label class="form-check-label" for="category-${category}">${category}</label>
					</div>
				</c:forEach>

				<!-- Giá -->
				<h6 class="mt-4 mb-2">GIÁ</h6>
				<div class="form-check">
					<input type="radio" class="form-check-input" name="price"
						id="price1" value="0-150000" ${gia == '0-150000' ? 'checked' : ''}
						onclick="filterResults()"> <label class="form-check-label"
						for="price1">0đ - 150,000đ</label>
				</div>
				<div class="form-check">
					<input type="radio" class="form-check-input" name="price"
						id="price2" value="150000-300000"
						${gia == '150000-300000' ? 'checked' : ''}
						onclick="filterResults()"> <label class="form-check-label"
						for="price2">150,000đ - 300,000đ</label>
				</div>
				<div class="form-check">
					<input type="radio" class="form-check-input" name="price"
						id="price3" value="300000-500000"
						${gia == '300000-500000' ? 'checked' : ''}
						onclick="filterResults()"> <label class="form-check-label"
						for="price3">300,000đ - 500,000đ</label>
				</div>
				<div class="form-check">
					<input type="radio" class="form-check-input" name="price"
						id="price4" value="500000-700000"
						${gia == '500000-700000' ? 'checked' : ''}
						onclick="filterResults()"> <label class="form-check-label"
						for="price4">500,000đ - 700,000đ</label>
				</div>
				<div class="form-check">
					<input type="radio" class="form-check-input" name="price"
						id="price5" value="700000-up"
						${gia == '700000-up' ? 'checked' : ''} onclick="filterResults()">
					<label class="form-check-label" for="price5">700,000đ - Trở
						Lên</label>
				</div>

				<!-- Nhà xuất bản -->
				<h6 class="mt-4 mb-2">NHÀ XUẤT BẢN</h6>
				<c:forEach var="publisher" items="${uniquePublishers}">
					<div class="form-check">
						<input type="radio" class="form-check-input" name="supplier"
							id="supplier-${publisher}" value="${publisher}"
							${nxb == publisher ? 'checked' : ''} onclick="filterResults()">
						<label class="form-check-label" for="supplier-${publisher}">${publisher}</label>
					</div>
				</c:forEach>

			</div>

		</div>


		<div class="col-sm-9 d-flex flex-wrap mx-auto">
			<div class="row">
				<!-- Lặp qua danh sách sách -->
				<c:forEach var="book" items="${books}">
					<div class="col-sm-4">
						<div class="card m-2 btn" style="width: 14rem;"
							onclick="selectBook('${book.id}')">
							<img src="<%= request.getContextPath() %>/Images/${book.image}"
								alt="${book.name}" class="card-img-top">
							<div class="card-body">
								<h5 class="card-title">${book.name}</h5>
								<p class="card-text">Giá gốc: ${book.originalPrice} VND</p>
								<p class="card-text">Giá bán: ${book.salePrice} VND</p>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>
		</div>
	</div>
	<nav aria-label="Page navigation example">
		<ul class="pagination">
			<li class="page-item"><a class="page-link" href="#">Previous</a></li>
			<li class="page-item"><a class="page-link" href="#">1</a></li>
			<li class="page-item"><a class="page-link" href="#">2</a></li>
			<li class="page-item"><a class="page-link" href="#">3</a></li>
			<li class="page-item"><a class="page-link" href="#">Next</a></li>
		</ul>
	</nav>
	<!-- Footer -->
	<div class="row mt-5" style="background-color: #282a35">
		<div class="col-sm-2 mt-5"></div>
		<div class="col-sm-4 mt-5">
			<div class="d-flex">
				<div>
					<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
						viewBox="0 0 303 303" fill="none">
                        <rect x="0.5" y="0.5" width="302" height="302"
							rx="38.5" fill="white" />
                        <rect x="0.5" y="0.5" width="302" height="302"
							rx="38.5" stroke="white" />
                        <mask id="path-2-outside-1_1_881"
							maskUnits="userSpaceOnUse" x="32" y="79" width="232" height="142"
							fill="black">
                            <rect fill="white" x="32" y="79" width="232"
							height="142" />
                            <path
							d="M79.3273 220C77.8607 220 76.6607 219.533 75.7273 218.6C74.794 217.667 74.3273 216.467 74.3273 215V111.4H38.7273C37.2607 111.4 36.0607 110.933 35.1273 110C34.194 108.933 33.7273 107.733 33.7273 106.4V85C33.7273 83.5333 34.194 82.3333 35.1273 81.4C36.0607 80.4667 37.2607 80 38.7273 80H146.327C147.794 80 148.994 80.4667 149.927 81.4C150.861 82.3333 151.327 83.5333 151.327 85V106.4C151.327 107.733 150.861 108.933 149.927 110C148.994 110.933 147.794 111.4 146.327 111.4H110.727V215C110.727 216.467 110.261 217.667 109.327 218.6C108.394 219.533 107.194 220 105.727 220H79.3273ZM161.952 220C160.486 220 159.286 219.533 158.352 218.6C157.419 217.667 156.952 216.467 156.952 215V121C156.952 119.533 157.419 118.333 158.352 117.4C159.286 116.467 160.486 116 161.952 116H184.952C186.419 116 187.619 116.467 188.552 117.4C189.486 118.333 189.952 119.533 189.952 121V128.6C193.419 124.467 197.952 121 203.552 118.2C209.152 115.4 215.752 114 223.352 114C231.086 114 237.886 115.733 243.752 119.2C249.752 122.667 254.419 127.8 257.752 134.6C261.219 141.267 262.952 149.467 262.952 159.2V215C262.952 216.467 262.419 217.667 261.352 218.6C260.419 219.533 259.286 220 257.952 220H232.752C231.419 220 230.219 219.533 229.152 218.6C228.219 217.667 227.752 216.467 227.752 215V160.4C227.752 154.133 226.219 149.333 223.152 146C220.219 142.533 215.819 140.8 209.952 140.8C204.486 140.8 200.086 142.533 196.752 146C193.552 149.333 191.952 154.133 191.952 160.4V215C191.952 216.467 191.419 217.667 190.352 218.6C189.419 219.533 188.286 220 186.952 220H161.952Z" />
                        </mask>
                        <path
							d="M79.3273 220C77.8607 220 76.6607 219.533 75.7273 218.6C74.794 217.667 74.3273 216.467 74.3273 215V111.4H38.7273C37.2607 111.4 36.0607 110.933 35.1273 110C34.194 108.933 33.7273 107.733 33.7273 106.4V85C33.7273 83.5333 34.194 82.3333 35.1273 81.4C36.0607 80.4667 37.2607 80 38.7273 80H146.327C147.794 80 148.994 80.4667 149.927 81.4C150.861 82.3333 151.327 83.5333 151.327 85V106.4C151.327 107.733 150.861 108.933 149.927 110C148.994 110.933 147.794 111.4 146.327 111.4H110.727V215C110.727 216.467 110.261 217.667 109.327 218.6C108.394 219.533 107.194 220 105.727 220H79.3273ZM161.952 220C160.486 220 159.286 219.533 158.352 218.6C157.419 217.667 156.952 216.467 156.952 215V121C156.952 119.533 157.419 118.333 158.352 117.4C159.286 116.467 160.486 116 161.952 116H184.952C186.419 116 187.619 116.467 188.552 117.4C189.486 118.333 189.952 119.533 189.952 121V128.6C193.419 124.467 197.952 121 203.552 118.2C209.152 115.4 215.752 114 223.352 114C231.086 114 237.886 115.733 243.752 119.2C249.752 122.667 254.419 127.8 257.752 134.6C261.219 141.267 262.952 149.467 262.952 159.2V215C262.952 216.467 262.419 217.667 261.352 218.6C260.419 219.533 259.286 220 257.952 220H232.752C231.419 220 230.219 219.533 229.152 218.6C228.219 217.667 227.752 216.467 227.752 215V160.4C227.752 154.133 226.219 149.333 223.152 146C220.219 142.533 215.819 140.8 209.952 140.8C204.486 140.8 200.086 142.533 196.752 146C193.552 149.333 191.952 154.133 191.952 160.4V215C191.952 216.467 191.419 217.667 190.352 218.6C189.419 219.533 188.286 220 186.952 220H161.952Z"
							fill="black" />
                        <path
							d="M75.7273 218.6L75.0202 219.307L75.7273 218.6ZM74.3273 111.4H75.3273V110.4H74.3273V111.4ZM35.1273 110L34.3748 110.659L34.3967 110.684L34.4202 110.707L35.1273 110ZM35.1273 81.4L35.8344 82.1071L35.8345 82.1071L35.1273 81.4ZM149.927 81.4L150.634 80.6929L149.927 81.4ZM149.927 110L150.634 110.707L150.658 110.684L150.68 110.658L149.927 110ZM110.727 111.4V110.4H109.727V111.4H110.727ZM79.3273 219C78.0936 219 77.1586 218.617 76.4345 217.893L75.0202 219.307C76.1628 220.45 77.6278 221 79.3273 221V219ZM76.4345 217.893C75.7103 217.169 75.3273 216.234 75.3273 215H73.3273C73.3273 216.7 73.8777 218.165 75.0202 219.307L76.4345 217.893ZM75.3273 215V111.4H73.3273V215H75.3273ZM74.3273 110.4H38.7273V112.4H74.3273V110.4ZM38.7273 110.4C37.4936 110.4 36.5586 110.017 35.8344 109.293L34.4202 110.707C35.5628 111.85 37.0278 112.4 38.7273 112.4V110.4ZM35.8799 109.341C35.0952 108.445 34.7273 107.475 34.7273 106.4H32.7273C32.7273 107.992 33.2929 109.422 34.3748 110.659L35.8799 109.341ZM34.7273 106.4V85H32.7273V106.4H34.7273ZM34.7273 85C34.7273 83.7662 35.1103 82.8312 35.8344 82.1071L34.4202 80.6929C33.2777 81.8354 32.7273 83.3004 32.7273 85H34.7273ZM35.8345 82.1071C36.5586 81.383 37.4936 81 38.7273 81V79C37.0278 79 35.5628 79.5503 34.4202 80.6929L35.8345 82.1071ZM38.7273 81H146.327V79H38.7273V81ZM146.327 81C147.561 81 148.496 81.383 149.22 82.1071L150.634 80.6929C149.492 79.5504 148.027 79 146.327 79V81ZM149.22 82.1071C149.944 82.8312 150.327 83.7662 150.327 85H152.327C152.327 83.3004 151.777 81.8354 150.634 80.6929L149.22 82.1071ZM150.327 85V106.4H152.327V85H150.327ZM150.327 106.4C150.327 107.475 149.96 108.445 149.175 109.341L150.68 110.658C151.762 109.422 152.327 107.992 152.327 106.4H150.327ZM149.22 109.293C148.496 110.017 147.561 110.4 146.327 110.4V112.4C148.027 112.4 149.492 111.85 150.634 110.707L149.22 109.293ZM146.327 110.4H110.727V112.4H146.327V110.4ZM109.727 111.4V215H111.727V111.4H109.727ZM109.727 215C109.727 216.234 109.344 217.169 108.62 217.893L110.034 219.307C111.177 218.165 111.727 216.7 111.727 215H109.727ZM108.62 217.893C107.896 218.617 106.961 219 105.727 219V221C107.427 221 108.892 220.45 110.034 219.307L108.62 217.893ZM105.727 219H79.3273V221H105.727V219ZM158.352 218.6L157.645 219.307L157.645 219.307L158.352 218.6ZM158.352 117.4L159.059 118.107L159.059 118.107L158.352 117.4ZM188.552 117.4L187.845 118.107L187.845 118.107L188.552 117.4ZM189.952 128.6H188.952V131.348L190.719 129.243L189.952 128.6ZM203.552 118.2L204 119.094L204 119.094L203.552 118.2ZM243.752 119.2L243.244 120.061L243.252 120.066L243.752 119.2ZM257.752 134.6L256.854 135.04L256.86 135.051L256.865 135.061L257.752 134.6ZM261.352 218.6L260.694 217.847L260.669 217.869L260.645 217.893L261.352 218.6ZM229.152 218.6L228.445 219.307L228.469 219.331L228.494 219.353L229.152 218.6ZM223.152 146L222.389 146.646L222.402 146.662L222.416 146.677L223.152 146ZM196.752 146L196.032 145.307L196.031 145.307L196.752 146ZM190.352 218.6L189.694 217.847L189.669 217.869L189.645 217.893L190.352 218.6ZM161.952 219C160.719 219 159.784 218.617 159.059 217.893L157.645 219.307C158.788 220.45 160.253 221 161.952 221V219ZM159.059 217.893C158.335 217.169 157.952 216.234 157.952 215H155.952C155.952 216.7 156.503 218.165 157.645 219.307L159.059 217.893ZM157.952 215V121H155.952V215H157.952ZM157.952 121C157.952 119.766 158.335 118.831 159.059 118.107L157.645 116.693C156.503 117.835 155.952 119.3 155.952 121H157.952ZM159.059 118.107C159.784 117.383 160.719 117 161.952 117V115C160.253 115 158.788 115.55 157.645 116.693L159.059 118.107ZM161.952 117H184.952V115H161.952V117ZM184.952 117C186.186 117 187.121 117.383 187.845 118.107L189.259 116.693C188.117 115.55 186.652 115 184.952 115V117ZM187.845 118.107C188.569 118.831 188.952 119.766 188.952 121H190.952C190.952 119.3 190.402 117.835 189.259 116.693L187.845 118.107ZM188.952 121V128.6H190.952V121H188.952ZM190.719 129.243C194.084 125.23 198.503 121.843 204 119.094L203.105 117.306C197.402 120.157 192.754 123.704 189.186 127.957L190.719 129.243ZM204 119.094C209.434 116.377 215.875 115 223.352 115V113C215.63 113 208.871 114.423 203.105 117.306L204 119.094ZM223.352 115C230.931 115 237.551 116.697 243.244 120.061L244.261 118.339C238.22 114.77 231.24 113 223.352 113V115ZM243.252 120.066C249.064 123.424 253.6 128.401 256.854 135.04L258.65 134.16C255.238 127.199 250.44 121.909 244.253 118.334L243.252 120.066ZM256.865 135.061C260.239 141.55 261.952 149.581 261.952 159.2H263.952C263.952 149.352 262.199 140.984 258.64 134.139L256.865 135.061ZM261.952 159.2V215H263.952V159.2H261.952ZM261.952 215C261.952 216.19 261.535 217.111 260.694 217.847L262.011 219.353C263.303 218.222 263.952 216.744 263.952 215H261.952ZM260.645 217.893C259.902 218.637 259.023 219 257.952 219V221C259.548 221 260.936 220.43 262.059 219.307L260.645 217.893ZM257.952 219H232.752V221H257.952V219ZM232.752 219C231.677 219 230.708 218.632 229.811 217.847L228.494 219.353C229.73 220.434 231.161 221 232.752 221V219ZM229.859 217.893C229.135 217.169 228.752 216.234 228.752 215H226.752C226.752 216.7 227.303 218.165 228.445 219.307L229.859 217.893ZM228.752 215V160.4H226.752V215H228.752ZM228.752 160.4C228.752 153.979 227.181 148.902 223.888 145.323L222.416 146.677C225.257 149.765 226.752 154.287 226.752 160.4H228.752ZM223.916 145.354C220.74 141.601 216.021 139.8 209.952 139.8V141.8C215.617 141.8 219.698 143.466 222.389 146.646L223.916 145.354ZM209.952 139.8C204.254 139.8 199.58 141.617 196.032 145.307L197.473 146.693C200.592 143.45 204.717 141.8 209.952 141.8V139.8ZM196.031 145.307C192.596 148.885 190.952 153.969 190.952 160.4H192.952C192.952 154.298 194.508 149.781 197.474 146.693L196.031 145.307ZM190.952 160.4V215H192.952V160.4H190.952ZM190.952 215C190.952 216.19 190.535 217.111 189.694 217.847L191.011 219.353C192.303 218.222 192.952 216.744 192.952 215H190.952ZM189.645 217.893C188.902 218.637 188.023 219 186.952 219V221C188.548 221 189.936 220.43 191.059 219.307L189.645 217.893ZM186.952 219H161.952V221H186.952V219Z"
							fill="black" mask="url(#path-2-outside-1_1_881)" />
                    </svg>
				</div>
				<div class="ms-2">
					<h4 class="text-light">dreambook.com</h4>
				</div>
			</div>
			<p class="text-light">123 Hung Vuong.</p>
			<div class="col-sm-2"></div>
		</div>
		<div class="col-sm-3 mt-5"></div>
		<div class="col-sm-3 mt-5">
			<div class="d-flex">
				<a class="nav-link text-light m-2" href="#"> <svg
						xmlns="http://www.w3.org/2000/svg" height="24" width="21"
						viewBox="0 0 448 512">
						<!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
                        <path fill="#dddddd"
							d="M416 32H31.9C14.3 32 0 46.5 0 64.3v383.4C0 465.5 14.3 480 31.9 480H416c17.6 0 32-14.5 32-32.3V64.3c0-17.8-14.4-32.3-32-32.3zM135.4 416H69V202.2h66.5V416zm-33.2-243c-21.3 0-38.5-17.3-38.5-38.5S80.9 96 102.2 96c21.2 0 38.5 17.3 38.5 38.5 0 21.3-17.2 38.5-38.5 38.5zm282.1 243h-66.4V312c0-24.8-.5-56.7-34.5-56.7-34.6 0-39.9 27-39.9 54.9V416h-66.4V202.2h63.7v29.2h.9c8.9-16.8 30.6-34.5 62.9-34.5 67.2 0 79.7 44.3 79.7 101.9V416z" />
                    </svg>
				</a> <a class="nav-link text-light m-2" href="#"> <svg
						xmlns="http://www.w3.org/2000/svg" height="24" width="23.25"
						viewBox="0 0 496 512">
						<!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
                        <path fill="#dddddd"
							d="M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3 .3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5 .3-6.2 2.3zm44.2-1.7c-2.9 .7-4.9 2.6-4.6 4.9 .3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8zM97.2 352.9c-1.3 1-1 3.3 .7 5.2 1.6 1.6 3.9 2.3 5.2 1 1.3-1 1-3.3-.7-5.2-1.6-1.6-3.9-2.3-5.2-1zm-10.8-8.1c-.7 1.3 .3 2.9 2.3 3.9 1.6 1 3.6 .7 4.3-.7 .7-1.3-.3-2.9-2.3-3.9-2-.6-3.6-.3-4.3 .7zm32.4 35.6c-1.6 1.3-1 4.3 1.3 6.2 2.3 2.3 5.2 2.6 6.5 1 1.3-1.3 .7-4.3-1.3-6.2-2.2-2.3-5.2-2.6-6.5-1zm-11.4-14.7c-1.6 1-1.6 3.6 0 5.9 1.6 2.3 4.3 3.3 5.6 2.3 1.6-1.3 1.6-3.9 0-6.2-1.4-2.3-4-3.3-5.6-2z" />
                    </svg>
				</a> <a class="nav-link text-light m-2" href="#"> <svg
						xmlns="http://www.w3.org/2000/svg" height="24" width="24"
						viewBox="0 0 512 512">
						<!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
                        <path fill="#dddddd"
							d="M512 256C512 114.6 397.4 0 256 0S0 114.6 0 256C0 376 82.7 476.8 194.2 504.5V334.2H141.4V256h52.8V222.3c0-87.1 39.4-127.5 125-127.5c16.2 0 44.2 3.2 55.7 6.4V172c-6-.6-16.5-1-29.6-1c-42 0-58.2 15.9-58.2 57.2V256h83.6l-14.4 78.2H287V510.1C413.8 494.8 512 386.9 512 256h0z" />
                    </svg>
				</a>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>
	<script>
		function selectBook(bookId) {
			// Điều hướng tới servlet với bookId dưới dạng query parameter
			window.location.href = `/Book/form_detail?bookId=` + bookId;

		}
		function FormCart(sdt, pass) {
			window.location.href = '/Book/ViewCart?sdt=' + sdt + '&pass='
					+ pass;
		}
		function home() {
			window.location.href = '/Book/read';
		}
		function filterResults() {
		    // Lấy giá trị của thể loại từ các radio button
		    const theLoai = document.querySelector('input[name="category"]:checked')?.value || "empty"	    
		    // Lấy giá trị của nhà xuất bản từ các radio button
		    const nhaXuatBan = document.querySelector('input[name="supplier"]:checked')?.value || "empty"	    
		    // Lấy giá trị của tác giả từ các radio button
		    const gia = document.querySelector('input[name="price"]:checked')?.value || "empty";
		 	// Lấy giá trị từ ô tìm kiếm
		    const searchValue = document.getElementById("searchInput").value || "empty";
		    // Chuyển hướng đến URL với các tham số
		    window.location.href = '/Book/read?theLoai=' + encodeURIComponent(theLoai) +
		                          '&nxb=' + encodeURIComponent(nhaXuatBan) +
		                          '&gia=' + encodeURIComponent(gia) + '&search=' + encodeURIComponent(searchValue); 
		}
		const searchInput = document.getElementById("searchInput");
        const suggestionsList = document.getElementById("suggestionsList");

     	// Chuyển danh sách từ JSP sang JavaScript
        const suggestions = [];
        <c:forEach var="suggestion" items="${uniqueName}">
            suggestions.push("${suggestion}");
        </c:forEach>

        // Hàm hiển thị gợi ý
        function showSuggestions(value) {
            suggestionsList.innerHTML = ""; // Xóa gợi ý cũ
            if (!value.trim()) {
                suggestionsList.style.display = "none"; // Ẩn nếu chuỗi rỗng
                return;
            }

            const filteredSuggestions = suggestions.filter(item => 
                item.toLowerCase().includes(value.toLowerCase())
            );

            if (filteredSuggestions.length > 0) {
                filteredSuggestions.forEach(suggestion => {
                    const li = document.createElement("li");
                    li.textContent = suggestion;
                    
                    // Gắn sự kiện click
                    li.addEventListener("click", () => {
                        handleSuggestionClick(suggestion);
                    });

                    suggestionsList.appendChild(li);
                });
                suggestionsList.style.display = "block"; // Hiển thị danh sách
            } else {
                suggestionsList.style.display = "none";
            }
        }
        function handleSuggestionClick(selectedValue) {
            searchInput.value = selectedValue; // Gắn giá trị vào ô tìm kiếm
            suggestionsList.style.display = "none"; // Ẩn gợi ý
            searchInput.focus(); // Đưa focus lại vào ô tìm kiếm
        }

        // Lắng nghe sự kiện nhập liệu
        searchInput.addEventListener("input", (e) => {
            const value = e.target.value;
            showSuggestions(value);
        });

        // Xử lý click bên ngoài để ẩn danh sách
        document.addEventListener("click", (e) => {
            if (!e.target.closest(".nav-item")) {
                suggestionsList.style.display = "none";
            }
        });
		document.getElementById('searchInput').addEventListener('keypress', function(event) {
		    if (event.key === 'Enter') {
		    	filterResults();
		    }
		});
	</script>
</body>
</html>