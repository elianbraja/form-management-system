# Task: Implement a Basic Form Management System (Rails)

## Objective
Build a minimal Rails application that allows the creation of forms, adding fields to them, and filling them multiple times with data.  
The focus is not on the front-end but on designing a clean database schema and ActiveRecord models that can support the requirements.

---

## Requirements

1. **Authentication**  
   Basic authentication using a password. Gems such as Devise are allowed.

2. **Authorization**  
   Users can only view or edit objects they created (e.g., Forms, Fields, etc.).  
   Authorization gems such as Pundit or CanCanCan are allowed.

3. **Fields**  
   Users can create fields for different input types and define validations on them:
    - **String** — length of the string
    - **Integer** — minimum and maximum value
    - **Datetime** — no validations required  
      Fields also have a name.

4. **Forms**
    - A form has a title and can contain multiple fields.
    - The same field can be used multiple times within a form.
    - A form can be filled multiple times, resulting in multiple form entries.

5. **Form Entries**  
   Once a form is created, a user can fill it multiple times and view or edit each entry.

6. **Data Retrieval**  
   A user can view all data of a form in a table view, where:
    - Rows represent the fields.
    - Columns represent the entries, numbered by order of creation.  
      **Optional:** Allow users to download this data as a CSV file.

7. **UI**
    - The UI should be simple but presentable, for example by using simple.css.
    - No external frontend libraries should be used.
    - If any interactivity is required, use Hotwire, Stimulus, or vanilla JavaScript.
    - Small bugs are acceptable as long as the main functionality is working.

---

## Deliverables

- Database schema (via migrations)
- ActiveRecord models with associations that meet the requirements
- Minimal Rails controllers and views (only as needed to demonstrate functionality)

---

## Notes
If you have any questions, please don’t hesitate to contact us.
