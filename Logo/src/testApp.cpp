#include "testApp.h"
#include "ofGLUtils.h"
#include "ofGLRenderer.h"
#include <iostream>
using namespace std;

//things to do
//work on fft
//be able to adjust brightness, contrast, saturation
//smooth out brightness so it doesn't peak
//add some special effects for when 1) brightness increases and 2) reaches a certain value

//--------------------------------------------------------------
void testApp::setup(){
    
    pause = false;
    
    //rotation variables
    rx = ry = rz = 0;
    
    
    fbo = new ofFbo;
    mesh = new ofMesh;
    mp3 = new ofSoundPlayer;
    cam = new ofEasyCam;
    
    //video
    videoPlayer = new ofVideoPlayer;
    
    //image
    //input = new ofImage;
    
    //video
    //vidGrabber = new ofVideoGrabber;
    
    
    fbo->allocate(5100, 3300, GL_RGB);
    logo.allocate(5100, 3300, OF_IMAGE_COLOR);
    
    
	camWidth 		=  1024;	// try to grab at this size. 
	camHeight 		=  768;
	
	//vidGrabber->initGrabber(camWidth,camHeight);
    mp3->loadSound("sounds/8As.mp3");
    //mp3.loadSound("sounds/grizzly.mp3");
    

    videoPlayer->loadMovie("megayes-9.MOV");
   //videoPlayer.loadMovie("sky_proxy_comp_1.mp4");
    
    //input->loadImage("megayes.jpg");

    videoPlayer->play();
    
        
    fftSmoothed = new float[8192];
	for (int i = 0; i < 8192; i++){
		fftSmoothed[i] = 0;
	}
	
    
    //use video
	nBandsToGet = videoPlayer->getHeight();
    
    //use camera
    //nBandsToGet = vidGrabber->getHeight();
    
    //use image
    //nBandsToGet = input->getHeight();
    
    //sound stuff
    
//    soundStream.setDeviceID(2);
//
//    soundStream.listDevices();
//    int bufferSize = 256;
//    
//    
//    left.assign(bufferSize, 0.0);
//	right.assign(bufferSize, 0.0);
//	volHistory.assign(400, 0.0);
//	
//	bufferCounter	= 0;
//	drawCounter		= 0;
//	smoothedVol     = 0.0;
//	scaledVol		= 0.0;
//    
//	soundStream.setup(this, 0, 2, 44100, bufferSize, 4);
    videoPlayer->setVolume(0);
    mp3->play();
    yStep = 3;
    xStep = 1;

    
}

//--------------------------------------------------------------
void testApp::update(){
    
    videoPlayer->setPaused(pause);
    mp3->setPaused(pause);

    
    //uncomment for video grabber
    //vidGrabber->update();
    
    // update the sound playing system:
	ofSoundUpdate();
    
    float * val = ofSoundGetSpectrum(nBandsToGet);		// request 128 values for fft
	for (int i = 0;i < nBandsToGet; i++){
		
		// let the smoothed value sink to zero:
		fftSmoothed[i] *= 0.96f;
		
		// take the max, either the smoothed or the incoming:
		if (fftSmoothed[i] < val[i]) fftSmoothed[i] = val[i];
		
	}
    
    
    videoPlayer->idleMovie();
    
    //update pixels for mesh
    
    
    //lets scale the vol up to a 0-1 range 
	scaledVol = ofMap(smoothedVol, 0.0, 0.17, 0.0, 1.0, true);
    
	//lets record the volume into an array
	volHistory.push_back( scaledVol );
	
	//if we are bigger the the size we want to record - lets drop the oldest value
	if( volHistory.size() >= 400 ){
		volHistory.erase(volHistory.begin(), volHistory.begin()+1);
	}
    
    //update pixels in vidpixels if we have a new video frame


    

    
    
        //video mesh
    if(videoPlayer->isFrameNew()){
        mesh->clear();

    vidPixels = videoPlayer->getPixelsRef();
        
        for (int y = 0; y<videoPlayer->height; y+=yStep){
            ofNoFill();
          //  ofMesh mesh;
            mesh->setMode(OF_PRIMITIVE_LINE_STRIP);
          //  mesh.setMode(GL_TRIANGLE_STRIP);
            
            for (int x = 0; x < videoPlayer->width; x += xStep){
                ofColor curColor = vidPixels.getColor(x, y);
                mesh->addColor(ofColor(curColor, 255));
                mesh->addVertex(ofVec3f(x, y, curColor.getBrightness() * 0.5 + fftSmoothed[y]*1000.f));
                //curColor.getBrightness() * .3 + scaledVol));
            }
        }
        

    }
    /*
     
     
    //camera mesh
    if(vidGrabber->isFrameNew()){
        mesh->clear();
        
        vidPixels = vidGrabber->getPixelsRef();
        
        for (int y = 0; y<vidGrabber->height; y+=yStep){
            ofNoFill();
            //  ofMesh mesh;
            mesh->setMode(OF_PRIMITIVE_LINE_STRIP);
            //  mesh.setMode(GL_TRIANGLE_STRIP);
            
            for (int x = 0; x < vidGrabber->width; x += xStep){
                ofColor curColor = vidPixels.getColor(x, y);
                mesh->addColor(ofColor(255));
                mesh->addVertex(ofVec3f(x, y, curColor.getBrightness() * 0.3 + fftSmoothed[y]*500.f));
                //curColor.getBrightness() * .3 + scaledVol));
            }
        }

        
        
        
    }
    
    
    //image mesh
    imgPixels = input->getPixelsRef();
    
    for(int y = 0; y < input->height; y+=yStep){
        
        ofNoFill();
        mesh->setMode(OF_PRIMITIVE_LINE_STRIP);
        
        for(int x =0; x < input->width; x+=xStep){
            ofColor curColor = input->getColor(x,y);
            mesh->addColor(ofColor(curColor, 255));
            mesh->addVertex(ofVec3f(x,y, curColor.getBrightness() * 0.3 + fftSmoothed[y]*500.f));
            
            
        }
        
    }
    */
    

    
}

//--------------------------------------------------------------
void testApp::draw(){
    
    ofBackground(155);
    
   fbo->begin();

   //light.enable();  
    ofClear(0,0,0,1);
    ofBackground(0);
    cam->begin();
    
    
    glEnable(GL_DEPTH_TEST);
    
    //scale mesh
    ofScale(5, 5, 5);
    
    //rotate mesh
    ofRotateY(ry);
    ofRotateX(rx);
    ofRotateZ(rz);
    
    //translate based on size of video
    
    
    //camera mesh
    //ofTranslate(-vidGrabber->width/2, -vidGrabber->height/2);
    
    //video mesh
    ofTranslate(-videoPlayer->width/2, -videoPlayer->height/2);
    
    //image mesh
    //ofTranslate(-input->width/2, -input->height/2);
    
    
    ofSetLineWidth(10);
    mesh->draw();
    cam->end();

    

    /*
    //draw framerate for fun
	ofSetColor(255);
	string msg = "fps: " + ofToString(ofGetFrameRate(), 2);
	ofDrawBitmapString(msg, 100, 200);
    */
    
    fbo->end();
   glPushMatrix();
    //glScalef(0.25, 0.25,0.25 );
    glScalef(1, 1, 1);            
    //fbo.draw(0, 0, 5100, 3300);
    
    fbo->draw(0, 0, 1024, 768);
              
   glPopMatrix();
}

//--------------------------------------------------------------

void testApp::audioIn(float * input, int bufferSize, int nChannels){	
	
	float curVol = 0.0;
	
	// samples are "interleaved"
	int numCounted = 0;	
    
	//lets go through each sample and calculate the root mean square which is a rough way to calculate volume	
	for (int i = 0; i < bufferSize; i++){
		left[i]		= input[i*2]*0.5;
		right[i]	= input[i*2+1]*0.5;
        
		curVol += left[i] * left[i];
		curVol += right[i] * right[i];
		numCounted+=2;
	}
	
	//this is how we get the mean of rms :) 
	curVol /= (float)numCounted;
	
	// this is how we get the root of rms :) 
	curVol = sqrt( curVol );
	
	smoothedVol *= 0.93;
	smoothedVol += 0.07 * curVol;
	
	bufferCounter++;
	
}

void testApp::save(){
    
    pixels.clear();
    
    fbo->readToPixels(pixels);
    
    
    ofSaveImage(pixels, "logo.tiff", OF_IMAGE_QUALITY_BEST);
    
    
    
}




//--------------------------------------------------------------
void testApp::keyPressed(int key){
    
    if(key=='y'){
        if(yStep<100)       
            yStep+=1;
        
    }
    
    if(key=='u'){
        if(yStep>1)
        yStep-=1;
    }
    
    if(key == ' '){
        
        pause = !pause;
        
    }

    if(key =='s'){
        
        save();
        
    }
    
    
    if(key == OF_KEY_UP){
        
        if(rx < 180) rx++;
        
    }
    
    if(key == OF_KEY_DOWN){
        if(rx > -180) rx--;
    }
    
    
    if(key == OF_KEY_RIGHT){
        
        if(ry < 180) ry++;
        
    }
    
    if(key == OF_KEY_LEFT){
        if(ry > -180) ry--;
    }
    
    if(key == '='){
        
        if(rz < 180) rz++;
        
    }
    
    if(key == '-'){
        if(rz > -180) rz--;
    }
    
    
    
    
    
}

//--------------------------------------------------------------
void testApp::keyReleased(int key){

}

//--------------------------------------------------------------
void testApp::mouseMoved(int x, int y){

}

//--------------------------------------------------------------
void testApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void testApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void testApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void testApp::dragEvent(ofDragInfo dragInfo){ 

}