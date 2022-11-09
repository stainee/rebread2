package common;

import java.io.File;

import org.springframework.stereotype.Component;

@Component
public class FileRename {
	public String fileRename(String path,String filename) {
		
		String onlyFilename = filename.substring(0,filename.lastIndexOf("."));//test (첫번째부터 마지막.의 앞까지만 추출)
		String extention = filename.substring(filename.lastIndexOf("."));//.txt (마지막 .부터 끝까지)
		//실제 업로드할 파일 명
		String filepath = null;
		//파일명이 중복되는 경우 뒤에 붙일 숫자
		int count = 0;
		while(true) {
			if(count == 0) {
				//파일이름체크 반복 첫번째인 경우
				filepath = onlyFilename+extention;//test.txt
			}else {
				filepath = onlyFilename+"_"+count+extention; //test_1.txt -->있으면 test_2.txt
			}
			File checkFile = new File(path+filepath);
			if(!checkFile.exists()) {
				//checkFile이 존재하는지 체크해줌
				//중복파일명이 아닌경우 무한반복문 나감
				break;
			}
			count++;
		}
		return filepath;
		
	}
}
