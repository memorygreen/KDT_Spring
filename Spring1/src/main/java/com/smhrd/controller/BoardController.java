package com.smhrd.controller;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.smhrd.entity.Board;
import com.smhrd.entity.Reply;
import com.smhrd.mapper.BoardMapper;

@Controller // 해당 클래스가 Controller가 되기 위한 명시

public class BoardController {
	
	@RequestMapping("/")
	public String home() {
		return "redirect:/boardList.do";
		
	}
	
	@Autowired
	private BoardMapper mapper;
	
	@RequestMapping("/boardList.do") // Client가 요청한 url 맵핑
	public String boardList(Model model) {
		System.out.println("게시글 전체보기 기능");
		// 게시글 정보 - 번호, 제목, 내용, 작성자, 작성일, 조회수
		List<Board> list = mapper.boardList();
		
		model.addAttribute("list", list);
		
		return "boardList";
		
		
	}
	
	@RequestMapping("/boardContent.do")
	public String boardContent(@RequestParam("idx") int idx, Model model) {
		System.out.println("게시글 상세보기 기능");
		
		// 게시글 조회수 1 올리는 기능 
		
		//자영 풀이
//		mapper.plusCount(idx);
		
		//쌤풀이
		mapper.boardCount(idx);
		Board vo = mapper.boardContent(idx);
		
		// 해당 게시글의 댓글 가져오기
		List<Reply> list = mapper.replyList(idx);
		
		
		model.addAttribute("vo", vo); //상세 게시글
		model.addAttribute("list", list); //댓글 리스트
		
		return "boardContent";
		
		
		
		
		
	}
	
	@RequestMapping("/boardForm.do")
	public String boardForm() {
		System.out.println("게시글 쓰기 페이지 이동 기능");
		return "boardForm";
	}
	
	@RequestMapping("/boardInsert.do")
	public String boardInsert(HttpServletRequest request) {
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
			
			//return "boardList";
			return "redirect:/boardList.do";
		
	}
	
	
	//자영풀이(240312 15:54) =>실패
	/*
	@RequestMapping("/boardDelete.do")
	private String boardDelete(@RequestParam("idx") int idx, Model model) {
		System.out.println("게시글 삭제 기능");
		Board vo = mapper.boardDelete(idx);
		model.addAttribute("vo", vo);
		
		return "redirect:/boardList.do";
	}
	*/
	
	// 동혁씨 도움 (완료)
//	@RequestMapping("/boardDelete.do")
//	private String boardDelete(Board vo) {
//		System.out.println("게시글 삭제 기능");
//		mapper.boardDelete(vo);
//		
//		return "redirect:/boardList.do";
//	}
	
	//쌤풀이
	@RequestMapping("/boardDelete.do")
	public String boardDelete(@RequestParam("idx") int idx) {
		System.out.println("게시글 삭제 기능");
		mapper.boardDelete(idx);
		return "redirect:/boardList.do";
	}
	
	@RequestMapping("/boardUpdateForm.do")
	public String boardUpdateForm(@RequestParam("idx") int idx, Model model) {
		System.out.println("게시글 수정페이지 이동 기능");
		Board vo = mapper.boardContent(idx);
		model.addAttribute("vo", vo);
		return "boardUpdateForm";
	}
	
	
	// 자영 실습(240313)
//	@RequestMapping("/boardUpdate.do")
//	public String boardUpdate(Board vo) {
//		System.out.println("게시글 수정 기능");
//		mapper.boardUpdate(vo);
//		return "redirect:/boardList.do";
//	}
	
	// 자영 실습2(240313(2))
//	@RequestMapping("/boardUpdate.do")
//	public String boardUpdate(@RequestParam("idx") int idx) { //안되는 이유 : 4개 데이터 보냈는데 idx만 보내줬기 때문! 하려면 4개를 리퀘스트 파람으로 다 보내줘야함!(그거 하기 싫어서 vo로 보내는거다)
//		System.out.println("게시글 수정 기능");
//		mapper.boardUpdate(idx);
//		return "redirect:/boardList.do";
//	}
	
	// 쌤풀이
	@RequestMapping("/boardUpdate.do")
	public String boardUpdate(Board vo) {
		System.out.println("게시글 수정 기능");
		mapper.boardUpdate(vo);
		return "redirect:/boardContent.do?idx="+vo.getIdx(); //자:수정된 화면 바로 볼 수 있도록 할것

	}
	
	
	
	//자영실습 조회수
	//@RequestMapping
	//public String plusCount() {
	//	System.out.println("조회수 증가 기능");
	//	mapper.plusCount();
	//	return "???";
	//}
	
	
	
	//댓글
	@RequestMapping("/replyInsert.do")
	public String replyInsert(Reply vo) {
		System.out.println("댓글 작성 기능");
		mapper.replyInsert(vo);
		return "redirect:/boardContent.do#view?idx="+vo.getBoardnum(); //자:댓글보고 상세보기 화면 으로 가야함 

	}
	
	
	
	
}
