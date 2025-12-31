import { Navigate } from "react-router-dom";
import { isUserLoggedIn } from "../utils/auth";

function ClientProtectedRoute({ children }) {
  // Check if user is logged in (not admin, just regular user)
  if (!isUserLoggedIn()) {
    return <Navigate to="/signin" replace />;
  }

  // Check if user is an admin - redirect admins away from client pages
  const isAdmin = localStorage.getItem('isAdmin') === 'true';
  if (isAdmin) {
    return <Navigate to="/admin/orders" replace />;
  }

  return children;
}

export default ClientProtectedRoute;
