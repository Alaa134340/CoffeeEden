import React from "react";
import axios from "axios";
import "../styles/Admin.css";
import API_URL from "../config";

function DeleteEvent({ id, onDelete }) {
  const handleDelete = async () => {
    try {
      const userId = localStorage.getItem('userId');
      await axios.delete(`${API_URL}/api/events/${id}`, {
        headers: {
          'user-id': userId
        }
      });
      if (onDelete) onDelete();
    } catch (error) {
      console.log('delete event error', error);
      alert('Failed to delete event');
    }
  };

  return (
    <button className="btn-delete" onClick={handleDelete}>
      Delete
    </button>
  );
}

export default DeleteEvent;
