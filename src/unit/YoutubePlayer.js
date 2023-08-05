import { useEffect, useState } from 'react'
import YouTube from 'react-youtube'
import { Badge } from 'reactstrap'
import { useTranslation } from 'react-i18next'

const YoutubePlater = (youtube) => {
  const { urlPath } = youtube
  const [myURL, setMyURL] = useState('')
  const { t } = useTranslation()
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
          <Badge color="info">{t('wrong_video_alert')}</Badge>
        </h3>
      ) : (
        <YouTube videoId={myURL} opts={opts} />
      )}
    </>
  )
}

export default YoutubePlater
