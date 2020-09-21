<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.example.services.ServiceFactoryImpl, com.example.services.PostService, com.example.beans.Post" %>


<%!
    PostService postService = null;
    public void jspInit(  ) {
        postService = ServiceFactoryImpl.getInstance().getPostService();
    }
%>
<%
    /*If user tries to click on browser back button then he/ she should not be able to access this page*/
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

        String userName = (String)session.getAttribute("userName");
        if (userName == null) {
        response.sendRedirect("/index.jsp");
    }
%>

<!DOCTYPE html>

<html lang="en">
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
        integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In or Sign Up</title>
</head>
<body>
    <jsp:include page="/Nav.jsp"/>
    <div class="container">
            <div class="row row-cols-1 row-cols-md-4">
            <%
                List<Post> posts = postService.getAllPost();
                if (posts == null) {
                %>

                <div class="alert alert-dark" role="alert" style="margin:100px auto; ">
                    No posts exist!!!
                </div>

                <%
                } else {
                    for (Post post: posts) { %>
                    <div class="col mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title"><%=post.getTitle() %></h5>
                            <p class="card-text"><%=post.getDescription() %></p>
                        </div>
                        <div class="card-footer">
                            <small class="text-muted">By: alan</small>
                            <small class="text-muted">10:15:</small>
                        </div>
                    </div>
                </div>
               <% }
            }
        %>
        </div>
    </div>
</body>
</html>