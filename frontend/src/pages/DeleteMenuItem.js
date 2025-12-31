import React from "react";
import axios from "axios";
import API_URL from "../config";
import "../styles/Admin.css";

function DeleteMenuItem({ id, onDelete }) {
  const handleDelete = async () => {
    try {
      const userId = localStorage.getItem('userId');
      await axios.delete(`${API_URL}/api/menu/${id}`, {
        headers: {
          'user-id': userId
        }
      });
      if (onDelete) onDelete();
    } catch (error) {
      console.log('delete menu item error', error);
      alert('Failed to delete menu item');
    }
  };

  return (
    <button className="admin-form" style={{background:'#c0392b',color:'#fff'}} onClick={handleDelete}>
      Delete
    </button>
  );
}

export default DeleteMenuItem;
