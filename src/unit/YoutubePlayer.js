import { useEffect, useState } from 'react'
import YouTube from 'react-youtube'
import { Badge } from 'reactstrap'

const YoutubePlater = (youtube) => {
  const { urlPath } = youtube
  const [myURL, setMyURL] = useState('')
  const opts = {
    height: '360',
    width: '640'
  }

  useEffect(() => {
    const urlArray = urlPath.split('/')
    setMyURL(urlArray[urlArray.length - 1])
  }, [urlPath])

  return (
    <>
      {!myURL ? (
        <h3>
          <Badge color="info">Ops there is something wrong with the video!</Badge>
        </h3>
      ) : (
        <YouTube videoId={myURL} opts={opts} />
      )}
    </>
  )
}

export default YoutubePlater
