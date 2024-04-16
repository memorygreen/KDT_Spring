package com.smhrd.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smhrd.entity.Board;
import com.smhrd.entity.Member;
import com.smhrd.entity.Reply;
import com.smhrd.mapper.BoardMapper;

@Controller // 해당 클래스가 Controller가 되기 위한 명시

public class BoardController {
	
	@Autowired
	private BoardMapper mapper;
	
	@Autowired
	private PasswordEncoder pwEnc;
	
	@RequestMapping("/")
	public String home() {
		return "main";
		
	}
	
	
	
	@RequestMapping("/boardList.do")
	public @ResponseBody List<Board> boardList(){
		System.out.println("게시글 전체보기 기능");
		List<Board> list = mapper.boardList();
		return list;
	}
	

	@RequestMapping("/boardCount.do/{idx}")
	public @ResponseBody void boardContent(@PathVariable("idx") int idx) {
		System.out.println("게시글 조회수 기능");		
		// 게시글 조회수 1 올리는 기능 		
		mapper.boardCount(idx);

	}
	
	@RequestMapping("/boardInsert.do")
	public @ResponseBody void boardInsert(HttpServletRequest request) {
	      // Board vo = new Board();
	      
	      // String title = request.getParameter("title");
	      // String content = request.getParameter("content");
	      // String writer = request.getParameter("writer");
	      
	      // vo.setTitle(title);
	      // vo.setContent(content);
	      // vo.setWriter(writer);
			
			System.out.println("게시글 입력 기능");
			
			//파일을 서버 폴더에 저장하는 객체	
			MultipartRequest multi = null;
			
			int fileMaxSize = 10 * 1024 * 10000;
			String savePath = request.getRealPath("resources/board");
			System.out.println(savePath);
			
			try {
				multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			String title = multi.getParameter("title");
			String content = multi.getParameter("content");
			String writer = multi.getParameter("writer");
			String imgpath = multi.getFilesystemName("imgpath");
				
			Board vo = new Board();
			vo.setTitle(title);
			vo.setContent(content);
			vo.setWriter(writer);
			vo.setImgpath(imgpath);
			
			System.out.println(vo.toString());//test용
			mapper.boardInsert(vo);	
	}
	
	
	//240318월 삭제기능
	//쌤풀이
  	@RequestMapping("/boardDelete.do/{idx}")
 	public @ResponseBody void boardDelete(@PathVariable("idx") int idx) {
 		System.out.println("게시글 삭제 기능");
 		mapper.boardDelete(idx);
 	}

	// 쌤풀이
	@RequestMapping("/boardUpdate.do")
	public @ResponseBody void boardUpdate(Board vo) {
		System.out.println("게시글 수정 기능");
		mapper.boardUpdate(vo);

	}

	@RequestMapping("/joinForm.do") //자:회원가입하는 페이지로 이동
	public String joinForm() {
		return "joinForm"; //자:뷰네임만 돌려줌 do는 안 붙는다!
	} 
	
	
	
	@RequestMapping("/join.do")
	public String join(Member vo) {
		
		
		String enPW = pwEnc.encode(vo.getPw());//자:암호화된 pw//pwEnc가 암호화해줌
		vo.setPw(enPW); //자:암호화된 비밀번호를 원래 비밀번호에 넣어주기
		
		
		mapper.join(vo);
		//return "main"; //회원가입시 join.do url에 남음
		return "redirect:/";
	}
	
	
	@RequestMapping("/loginForm.do")
	public String loginForm() {
		return "loginForm";
	}
	
	@RequestMapping("/login.do")
	public String login(Member vo, HttpSession session) {
		Member info = mapper.login(vo);
		
		if(info != null) {
			if(pwEnc.matches(vo.getPw(), info.getPw())){
				//비교 //info ->id일치하는 사람
				session.setAttribute("info", info);
			}
		}
		return "redirect:/";
	}
	
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	
	
}
