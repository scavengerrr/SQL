SELECT 
    TICKET.ID AS 'Ticket ID', 
    TICKET.TITLE AS 'Title', 
    TICKET.CREATED AS 'Created Date', 
    TICKET.MODIFIED AS 'Last Modified Date', 
    QUEUE.NAME AS 'Queue',
    STATUS.NAME AS 'Status',
    ASSIGNED_USER.FULL_NAME AS 'Assigned To'  -- Adding the assigned user's name
FROM 
    HD_TICKET TICKET
JOIN 
    HD_QUEUE QUEUE ON TICKET.HD_QUEUE_ID = QUEUE.ID
JOIN 
    HD_STATUS STATUS ON TICKET.HD_STATUS_ID = STATUS.ID  -- Adjusting for status lookup
JOIN 
    USER ASSIGNED_USER ON TICKET.OWNER_ID = ASSIGNED_USER.ID  -- Adjusting for the correct column name
WHERE 
    DATEDIFF(NOW(), TICKET.MODIFIED) >= 7
    AND STATUS.NAME NOT IN ('Closed', 'Resolved')  -- Checking the status by name
    AND QUEUE.NAME = 'ITS'
ORDER BY 
    TICKET.MODIFIED ASC;