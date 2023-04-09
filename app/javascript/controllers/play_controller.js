import { Controller } from "@hotwired/stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
  static targets = ['audio'];

  connect() {
    this.audioPlayer = this.audioTarget;
  }

  play(event) {
    event.preventDefault();
    const vinylId = this.data.get('vinylId');
    Rails.ajax({
      url: `/vinyls/${vinylId}/get_music_url`,
      type: 'GET',
      success: (data) => {
        this.audioPlayer.src = data.music_url;
        this.audioPlayer.play();
      },
      error: (data) => {
        console.log('Error retrieving music URL');
      }
    });
  }
}
