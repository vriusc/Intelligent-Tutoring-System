import './App.css'
import { RouterProvider, createBrowserRouter } from 'react-router-dom'
import ErrorPage from './error-page'
import Home from './Home'
import Login from './login/Login'

const router = createBrowserRouter([
  {
    path: '/',
    element: <Home />,
    errorElement: <ErrorPage />
  },
  {
    path: '/login',
    element: <Login />
  }
])

function App() {
  return <RouterProvider router={router} />
}
export default App

// function Root() {
//   return (
//     <Routes>
//       <Route path="/login" element={<Login />} />
//     </Routes>
//   )
// }
