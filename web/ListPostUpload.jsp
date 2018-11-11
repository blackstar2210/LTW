<%-- 
    Document   : PostUpload
    Created on : Oct 29, 2018, 11:39:44 PM
    Author     : User
--%>

<%@page import="DAO.PostDao"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/post.css" rel="stylesheet" type="text/css" media="all" />
    </head>
    <body>
             
        <% String param = request.getParameter("loadPost");%>
        <% PostDao pd = new PostDao(); %>
        <% for(Post p : pd.getListPost(param)){%>
            <div class="upload">
                <div class="postusername"><b><%= p.getPostUserName() %></b></div>
                <div class="upload-nalo">
                    <div class="upload-name"><b><%=p.getPostName()%></b></div>
                    <div class="upload-location"><%=p.getPostLocation()%></div>
                </div>
                <br><br>
    
                <div class="post-article">
                    <div class="post-content"><%=p.getPostContent()%></div>
                    <a href="DetailUpload.jsp?postID=<%=p.getPostID()%>">
                        <div class="post-img" style="background-image: url('PostImages/<%=p.getPostFileName()%>')"></div>
                    </a>
                </div>
                <center>
                    <hr>
                    <div style="width: 100%;">
                        <div class="fix-btn"></div>
                        <button class="btn" onclick="liked()" value="0" id="btnLike">
                            <img id="imgLike" src="img/love.png" width="15px" height="15px"> Like
                        </button>
                        <button class="btn">
                            <img src="img/love.png" width="15px" height="15px"> Comment
                        </button>
                        <div class="fix-btn"></div>
                    </div>
                </center>
            </div>
        <% } %>
        
    </body>
</html>

<script type="text/javascript">
    function liked(){
        var checkLike = document.getElementById('btnLike').value;
        if(checkLike == 0)
        {
            document.getElementById('imgLike').style.backgroundColor = "#fb5e33";
            document.getElementById('btnLike').value = 1;
        }
        else
        {
            document.getElementById('imgLike').style.backgroundColor = "white";
            document.getElementById('btnLike').value = 0;
        }
    }
</script>
