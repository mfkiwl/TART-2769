import {
    Component,
    Input,
    Output,
    ViewChild,
    ElementRef,
    EventEmitter
} from '@angular/core';
const gifshot = require('gifshot/build/gifshot');
import * as moment from 'moment/moment';

@Component({
    selector: 'app-gif-recorder',
    templateUrl: './gif-recorder.component.html',
    styleUrls: ['./gif-recorder.component.css']
})
export class GifRecorderComponent {
    @ViewChild('gifDisplay') gifDisplay: ElementRef;

    @Input()
    dataSource: any[] = [];

    @Input()
    numFrames: number = 0;

    @Output()
    clickedStart = new EventEmitter();

    @Output()
    clickedStop = new EventEmitter();

    @Output()
    clickedReset = new EventEmitter();

    isRecording: boolean = false;
    hasGif: boolean = false;

    constructor() { }

    onStartClick(event) {
        this.isRecording = true;
        this.clickedStart.emit(event);
    }

    onStopClick(event) {
        this.isRecording = false;
        this.clickedStop.emit(event);
    }

    onClickedReset(event) {
        this.clickedReset.emit(event);
        this.gifDisplay.nativeElement.src = "//:0";
        this.hasGif = false;
    }

    onSaveGifClick(event) {
        gifshot.createGIF({ images: this.dataSource }, (obj) => {
            if (!obj.error) {
                let image = obj.image;
                this.gifDisplay.nativeElement.src = image;
                this.hasGif = true;
            }
      });
    }

    onClickedDownloadBtn(event) {
        let image = this.gifDisplay.nativeElement.src;
        let downloadLink = document.createElement('a')
        downloadLink.download = this.generateGifFilename();
        downloadLink.href = image;
        downloadLink.click();
    }

    generateGifFilename() {
        let timestamp = moment().format();
        let gmtDateTime = moment.utc(timestamp);
        let localDateTime = gmtDateTime.local().format("YYYY_MM_DD_HH_mm_ss");
        return `radio_gif_${localDateTime}`;
    }
}
