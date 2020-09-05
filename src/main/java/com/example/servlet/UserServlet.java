package com.example.servlet;

import com.example.beans.User;
import com.example.services.ServiceFactory;
import com.example.services.ServiceFactoryImpl;
import com.example.services.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value = "/user")
public class UserServlet extends HttpServlet {

    UserService userService;

    @Override
    public void init() {
        ServiceFactory serviceFactory = new ServiceFactoryImpl();
        userService = serviceFactory.getUserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("email") == null) {
            resp.sendRedirect("/index.jsp");
        } else {
            resp.sendRedirect("/Home.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        if (session.getAttribute("email") != null) {
            resp.sendRedirect("/Home.jsp");
        } else {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String button = req.getParameter("button");

            if (button.equals("Sign In")) {

                User user = userService.getUser(new User(email, password));

                if (user.getEmail().equals(email)) {
                    session.setAttribute("email", email);
                    req.getRequestDispatcher("/Home.jsp").forward(req, resp);
                } else {
                    req.setAttribute("errorMsg", "Invalid credentials!");
                    req.getRequestDispatcher("/index.jsp").forward(req, resp);
                }

            } else if (button.equals("Sign Up")) {

                User user = userService.createUser(new User(email, password));

                if (user.getEmail().equals(email)) {
                    session.setAttribute("email", email);
                    req.getRequestDispatcher("/Home.jsp").forward(req, resp);
                } else {
                    req.setAttribute("errorMsg", "User already exists!");
                    req.getRequestDispatcher("/index.jsp").forward(req, resp);
                }
            }
        }
    }
}
