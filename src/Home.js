// import { Navigate } from 'react-router-dom'
import Header from './element/Header'
import logo from './assets/logo.svg'

const Home = () => {
  // const user = false
  // if (!user) {
  //   return <Navigate replace to="/login" />
  // }

  return (
    <>
      <Header />
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <p>
            Edit <code>src/App.js</code> and save to reload.
          </p>
          <a
            className="App-link"
            href="https://reactjs.org"
            target="_blank"
            rel="noopener noreferrer"
          >
            Learn React
          </a>
        </div>
      </div>
    </>
  )
}

export default Home
