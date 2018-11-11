<%-- 
    Document   : DetailUpload
    Created on : Nov 6, 2018, 2:30:06 PM
    Author     : User
--%>

<%@page import="model.Comment"%>
<%@page import="DAO.CommentDao"%>
<%@page import="model.User"%>
<%@page import="DAO.PostDao"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/post.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/comment.css" rel="stylesheet" type="text/css" media="all" />
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <br><br><br><br>
        <% 
            User user = new User();
            if(session.getAttribute("user") != null)
            {
                user = (User) session.getAttribute("user");        
                Post post = new Post();
                PostDao pd = new PostDao();
                String postID = "";

                if(request.getParameter("postID") != null){
                    postID = request.getParameter("postID");
                    post = pd.getPost(postID);
                }
        %>
        
        <div class="post">
            <div class="fix-detail-post"></div>
            <div class="detail-post">  
                <div class="upload">
                    <div class="postusername"><b><%= post.getPostUserName() %></b></div>

                    <div class="upload-nalo">
                        <div class="upload-name"><b><%=post.getPostName()%></b></div>
                        <div class="upload-location"><%=post.getPostLocation()%></div>
                    </div>  <br>

                    <div class="upload-content">
                        <%= post.getPostContent()%>
                    </div>    

                    <center>
                        <img src="PostImages/<%=post.getPostFileName() %>" width="500px" height="500px">
                    </center>
                    <center>
                        <hr>
                        <div style="width: 100%;">
                            <div class="fix-btn"></div>
                            <button class="btn" style="margin: 0;">
                                <img src="img/love.png" width="15px" height="15px"> Like
                            </button>
                            <button class="btn" style="margin: 0;">
                                <img src="img/love.png" width="15px" height="15px"> Comment
                            </button>
                            <div class="fix-btn"></div>
                        </div>
                        <hr> <br>
                    </center>
                    <%
                        for(Comment cmt : CommentDao.getListComment(post.getPostID())){
                    %>
                    <center>
                        <div class="zone-comment">
                            <div class="username-comment">
                                <b><%= cmt.getUserCommentName() %></b>
                            </div>
                            <div class="content-comment">
                                <%= cmt.getCommentContent() %>
                            </div>
                        </div>
                    </center> <br>

                    <% } %>

                    <center>
                        <div class="form-comment">
                            <form action="CommentServlet" method="POST" class="form-comments">
                                <div class="user-comment"><b><%=user.getUsername()%></b></div>
                                <div class="input-comment">
                                    <input type="text" name="content_comment" placeholder="  Write a comment..." class="add-comment">
                                    <input type="hidden" value="<%=post.getPostID()%>" name="postID">
                                </div>
                            </form>
                        </div>
                    </center>
                </div>
            </div>  
            <div class="fix-detail-post"></div>
        </div>
        <%
            } else {
        %>        
        <jsp:include page="signup.jsp"></jsp:include>
        <% } %>
    </body>
</html>
