import './App.css'
import { RouterProvider, createBrowserRouter } from 'react-router-dom'
import ErrorPage from './error-page'
import Home from './home/Home'
import Login from './login/Login'
import Course from './course/Course'

const router = createBrowserRouter([
  {
    path: '/',
    element: <Home />,
    errorElement: <ErrorPage />
  },
  {
    path: '/login',
    element: <Login />
  },
  {
    path: '/courses',
    element: <Course />
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
