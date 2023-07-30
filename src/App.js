import './App.css'
import { RouterProvider, createBrowserRouter } from 'react-router-dom'
import ErrorPage from './error-page'
import Home from './home/Home'
import Login from './login/Login'
import CoursesList from './course/Course-list'
import Course, { loader as unitsLoader } from './course/Course'
import Unit, { loader as unitIdLoader } from './unit/Unit'
import Questionnaire from './home/Questionnaire'
import History, { loader as historyLoader } from './history/History'
import WritingTest from './WritingTest'

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
    path: '/questionnaire',
    element: <Questionnaire />
  },
  {
    path: '/courses',
    element: <CoursesList />
  },
  {
    path: '/courses/:courseId',
    element: <Course />,
    loader: unitsLoader
  },
  {
    path: '/courses/:courseId/unit/:unitId',
    element: <Unit />,
    loader: unitIdLoader
  },
  {
    path: '/courses/:courseId/history/:unitId/',
    element: <History />,
    loader: historyLoader
  },
  {
    path: '/writingTest',
    element: <WritingTest />
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
