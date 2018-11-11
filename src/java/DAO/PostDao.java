/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import connect.JDBCConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Post;

/**
 *
 * @author User
 */
public class PostDao {
    public static boolean UploadPost(Post post){
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "insert into post(post_name,post_location,post_filename,post_content,post_image,post_category,user_id,user_name)"
                + " values(?,?,?,?,?,?,?,?)";
        PreparedStatement ps = null;
        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, post.getPostName());
            ps.setString(2, post.getPostLocation());
            ps.setString(3, post.getPostFileName());
            ps.setString(4, post.getPostContent());
            ps.setString(5, post.getPostImage());
            ps.setLong(6, post.getPostCategory());
            ps.setLong(7, post.getPostUserId());
            ps.setString(8, post.getPostUserName());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false; 
    }
    
    public ArrayList<Post> getListPost(String category) throws SQLException{
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = null;
        if(category.equalsIgnoreCase("full")){
            sql = "SELECT * FROM post ORDER BY post_id DESC";
        }
        else if(category.equalsIgnoreCase("food")){
            sql = "SELECT * FROM post WHERE post_category = 1 ORDER BY post_id DESC";
        }
        else if(category.equalsIgnoreCase("travelling")){
            sql = "SELECT * FROM post WHERE post_category = 2 ORDER BY post_id DESC";
        } else {
            sql = "SELECT * FROM post WHERE user_id = " + category + " ORDER BY post_id DESC";       
        }
        
        PreparedStatement ps = con.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Post> list = new ArrayList<>();
        while(rs.next()){
            Post post = new Post();
            post.setPostID(rs.getLong("post_id"));
            post.setPostName(rs.getString("post_name"));
            post.setPostLocation(rs.getString("post_location"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostFileName(rs.getString("post_filename"));
            post.setPostImage(rs.getString("post_image"));
            post.setPostCategory(rs.getLong("post_category"));
            post.setPostUserName(rs.getString("user_name"));
            post.setPostUserId(rs.getLong("user_id"));
            list.add(post);
        }
        return list;
    }
    
    public Post getPost(String postID) throws SQLException{
        Connection con = JDBCConnection.getJDBCConnection();
        String sql = "SELECT * FROM post WHERE post_id = '"+postID+"'";
        PreparedStatement ps = con.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        Post post = new Post();
        while(rs.next()){
            post.setPostID(rs.getLong("post_id"));
            post.setPostName(rs.getString("post_name"));
            post.setPostLocation(rs.getString("post_location"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostFileName(rs.getString("post_filename"));
            post.setPostImage(rs.getString("post_image"));
            post.setPostCategory(rs.getLong("post_category"));
            post.setPostUserName(rs.getString("user_name"));
            post.setPostUserId(rs.getLong("user_id"));
        }
        return post;
    }
}
