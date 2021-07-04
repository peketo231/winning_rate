User.seed(
  :id,
  { id: 1, email: 'admin@example.com', crypted_password: User.encrypt('password'), role: :admin },
  { id: 2, email: 'general@example.com', crypted_password: User.encrypt('password'), role: :general },
)