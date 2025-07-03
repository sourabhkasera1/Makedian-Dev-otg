import { LightningElement, track } from 'lwc';

export default class FetchAddressFromIP extends LightningElement {

     @track ip = '';
  @track country = '';
  @track city = '';
  @track region = '';

  connectedCallback() {
    fetch('https://ipinfo.io/json?token=YOUR_API_TOKEN') // <-- Replace this with your real token
      .then((response) => response.json())
      .then((data) => {
        this.ip = data.ip;
        this.country = data.country;
        this.city = data.city;
        this.region = data.region;
      })
      .catch((error) => {
        console.error('Failed to fetch geolocation:', error);
      });
  }


}