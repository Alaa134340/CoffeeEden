import React, { useState } from "react";
import axios from "axios";
import API_URL from "../config";
import "../styles/Admin.css";

function EditEvent({ event, onUpdate, onCancel }) {
  const [form, setForm] = useState(event || { name: "", description: ""});
  const [image, setImage] = useState(null);
  const [imagePreview, setImagePreview] = useState(
    event?.image_path ? `${API_URL}${event.image_path}` : null
  );
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    setImage(file);
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setImagePreview(reader.result);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    
    try {
      const userId = localStorage.getItem('userId');
      const formData = new FormData();
      formData.append('name', form.name);
      formData.append('description', form.description);
      if (image) {
        formData.append('image', image);
      }
      
      await axios.put(`${API_URL}/api/events/${event.id}`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
          'user-id': userId
        }
      });
      
      setLoading(false);
      if (onUpdate) onUpdate();
      alert('Event updated successfully!');
    } catch (err) {
      setError(err.message);
      setLoading(false);
      console.log('update event error:', err);
      alert('Failed to update event: ' + (err.response?.data?.error || err.message));
    }
  };

  return (
    <div className="admin-form-container">
      <h2> Edit Event</h2>
      {error && <div className="error-message">{error}</div>}
      
      <form className="admin-form-vertical" onSubmit={handleSubmit} encType="multipart/form-data">
        <div className="form-group">
          <label>Event Name</label>
          <input 
            name="name" 
            placeholder="Enter event name" 
            value={form.name} 
            onChange={handleChange} 
            required 
          />
        </div>

        <div className="form-group">
          <label>Description</label>
          <textarea 
            name="description" 
            placeholder="Enter event description" 
            value={form.description} 
            onChange={handleChange} 
            required 
            rows="5"
          />
        </div>

        <div className="form-group">
          <label>Event Image</label>
          <input 
            type="file" 
            name="image" 
            accept="image/*" 
            onChange={handleImageChange}
            className="file-input"
          />
          <small className="help-text">Optional: Upload a new image to replace the current one</small>
          {imagePreview && (
            <div className="image-preview">
              <img src={imagePreview} alt="Preview" />
              <p>{image ? `📎 ${image.name}` : ' Current image'}</p>
            </div>
          )}
        </div>

        <div className="form-actions">
          <button type="submit" className="btn-submit" disabled={loading}>
            {loading ? ' Updating...' : '✓ Update Event'}
          </button>
          {onCancel && (
            <button type="button" className="btn-cancel" onClick={onCancel}>
               Cancel
            </button>
          )}
        </div>
      </form>
    </div>
  );
}

export default EditEvent;
