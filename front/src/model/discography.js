import axios from 'axios';

export default class Discography {
  property() {
    return {
      artist: '',
      title: '',
      sales_start_at: '',
      label: '',
      chart: '',
      explanation: '',
      discography_type: 0
    }
  }
}
