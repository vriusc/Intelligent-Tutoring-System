import { useEffect, useRef } from 'react'
import './Video.css'

const VideoSocket = () => {
  const videoRef = useRef(null)

  useEffect(() => {
    // Function to handle video stream
    const handleVideoStream = (stream) => {
      videoRef.current.srcObject = stream
    }

    // Function to handle errors
    const handleError = (error) => {
      console.error('Error accessing camera:', error)
    }

    // Request access to the user's camera
    navigator.mediaDevices.getUserMedia({ video: true }).then(handleVideoStream).catch(handleError)
  }, [])

  return (
    <div className="Video-component">
      <video ref={videoRef} autoPlay muted width={200} height={160}></video>
    </div>
  )
}

export default VideoSocket
