import './App.css'
import { useRouteError } from 'react-router-dom'
import { Badge } from 'reactstrap'

const ErrorPage = () => {
  const error = useRouteError()
  console.error(error)

  return (
    <div id="error-page" className="Error-page">
      <h1>
        <Badge>Opps!</Badge>
      </h1>
      <p>Sorry, an unexpected error has occurred.</p>
      <p>
        <i>{error.statusText || error.message}</i>
      </p>
    </div>
  )
}

export default ErrorPage
