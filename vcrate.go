package vcrate

import (
	"io/ioutil"
	"net/http"
)

func vcrate() (body string, retErr error) {
	url := "https://coincheck.com/api/rate/xrp_jpy"
	client := &http.Client{}

	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return "", err
	}

	res, err := client.Do(req)
	if err != nil {
		return "", err
	}

	defer res.Body.Close()

	resBody, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return "", err
	}

	return string(resBody), nil
}
