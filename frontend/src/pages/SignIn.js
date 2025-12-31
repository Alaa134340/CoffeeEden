import React, { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import "../styles/Admin.css";
import API_URL from "../config";

function SignIn() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");

    if (!email || !password) {
      setError("Email and password are required");
      return;
    }

    try {
      const response = await fetch(`${API_URL}/api/auth/signin`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ email, password }),
      });

      const data = await response.json();

      if (!response.ok) {
        setError(data.error || "Login failed");
        return;
      }

      // Store user info in localStorage
      localStorage.setItem("userId", data.id);
      localStorage.setItem("username", data.username);
      localStorage.setItem("userEmail", data.email);
      localStorage.setItem("isAdmin", data.is_admin);

      // If admin, set admin token
      if (data.is_admin) {
        localStorage.setItem("adminToken", "mysecrettoken");
        navigate("/admin/menu");
      } else {
        navigate("/orders");
      }
    } catch (err) {
      setError("An error occurred. Please try again.");
      console.error(err);
    }
  };

  return (
    <div className="auth-container">
      <div className="auth-card">
        <h2 className="auth-title"> Sign In</h2>
        <p className="auth-subtitle">Welcome back to Coffee Haven</p>

        <form onSubmit={handleSubmit} className="auth-form">
          <div className="form-group">
            <label>Email</label>
            <input
              type="email"
              placeholder="Enter your email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>

          <div className="form-group">
            <label> Password</label>
            <input
              type="password"
              placeholder="Enter your password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>

          <button type="submit" className="btn-submit">Sign In</button>
        </form>

        {error && <p className="error-message">{error}</p>}

        <p className="auth-link">
          Don't have an account? <Link to="/signup" className="link-brown">Sign Up</Link>
        </p>
      </div>
    </div>
  );
}

export default SignIn;
