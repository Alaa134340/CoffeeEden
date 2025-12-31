
import React, { useEffect, useState } from "react";
import AddEvent from "./AddEvent";
import EditEvent from "./EditEvent";
import DeleteEvent from "./DeleteEvent";
import "../styles/Admin.css";
import API_URL from "../config";

function AdminEventManagement() {
  const [events, setEvents] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [editingEvent, setEditingEvent] = useState(null);
  const [showAdd, setShowAdd] = useState(false);

  const fetchEvents = () => {
    setLoading(true);
    fetch(`${API_URL}/api/events`)
      .then(res => {
        if (!res.ok) throw new Error("Failed to fetch events");
        return res.json();
      })
      .then(data => {
        setEvents(data);
        setLoading(false);
      })
      .catch(() => {
        setError("Failed to fetch events");
        setLoading(false);
      });
  };

  useEffect(() => {
    fetchEvents();
  }, []);

  const handleAdd = () => {
    setShowAdd(false);
    fetchEvents();
  };

  const handleEdit = (event) => {
    setEditingEvent(event);
  };

  const handleUpdate = () => {
    setEditingEvent(null);
    fetchEvents();
  };

  const handleDelete = () => {
    fetchEvents();
  };

  return (
    <div className="admin-container">
      <h2 className="admin-title">Event Management</h2>
      
      <div className="admin-actions">
        <button className="btn btn-primary" onClick={() => {
          setShowAdd(!showAdd);
          setEditingEvent(null);
        }}>
          {showAdd ? '✕ Cancel' : '+ Add New Event'}
        </button>
      </div>

      {showAdd && (
        <div className="form-section">
          <AddEvent onAdd={handleAdd} />
        </div>
      )}
      
      {editingEvent && (
        <div className="form-section">
          <EditEvent event={editingEvent} onUpdate={handleUpdate} onCancel={() => setEditingEvent(null)} />
        </div>
      )}
      
      {loading ? (
        <div className="loading-state">Loading events...</div>
      ) : error ? (
        <div className="error-state">{error}</div>
      ) : (
        <div className="table-section">
          <h3 className="section-subtitle">All Events</h3>
          <div className="events-grid">
            {events.map(event => (
              <div key={event.id} className="event-card">
                <div className="event-field">
                  <span className="field-label">Name:</span>
                  <span className="field-value">{event.name}</span>
                </div>
                <div className="event-field">
                  <span className="field-label">Description:</span>
                  <span className="field-value">{event.description}</span>
                </div>
                <div className="event-actions">
                  <button className="btn-edit" onClick={() => {
                    setEditingEvent(event);
                    setShowAdd(false);
                  }}>
                    Edit
                  </button>
                  <DeleteEvent id={event.id} onDelete={handleDelete} />
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

export default AdminEventManagement;
