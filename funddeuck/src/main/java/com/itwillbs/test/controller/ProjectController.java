package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itwillbs.test.handler.EchoHandler;
import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.PaymentService;
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.ChartDataVO;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.MembersVO;
import com.itwillbs.test.vo.PaymentVO;
import com.itwillbs.test.vo.ProjectVO;
import com.itwillbs.test.vo.RewardVO;

@Controller
public class ProjectController {
	
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MakerService makerService;
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private MemberService memberService;
	
	private EchoHandler echoHandler;
	@Autowired
	public ProjectController(EchoHandler echoHandler) {
		this.echoHandler = echoHandler;
	}
	
	// ������Ʈ ����
	@GetMapping("project")
	public String projectMain() {
		return "project/project_main";
	}
	
	// ������Ʈ ���� ��û
	@GetMapping("approvalRequest")
	@ResponseBody
	public String approvalRequest(@RequestParam int project_idx, HttpServletRequest request) {
		System.out.println("approvalRequest - " + project_idx);
		// �Ķ���ͷ� ���޹��� project_idx�� project_approve_status ���¸� 2-���ο�û���� ����!
		// ������Ʈ ���� ���� 1-�̽��� 2-���ο�û 3-���� 4-�ݷ�
		// ������ ������������ 2-���ο�û�ΰ͸� ����Ѵ�!
		int updateCount = projectService.modifyStatus(project_idx);
		if(updateCount > 0) {
			// �����ڿ��� ���� ��û toast �˾� ����
			// toast Ŭ�� �� �������� ������Ʈ ���� �������� �̵�
			String adminProjectUrl = 
				request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/test/adminProjectList";
//				request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/funddeuck/adminProjectList";
			String notification = 
					"<a href='" + adminProjectUrl + "' style='text-decoration: none; color: black;'>����Ŀ�Բ��� ������Ʈ ������ ��û�Ͽ����ϴ�.</a>";
			try {
				echoHandler.sendNotificationToUser("admin", notification);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "true"; 
		} 
		return "false"; 
	}
	
	// �ۼ����� ������Ʈ�� �̵�
	@GetMapping("projectUrl")
	public ModelAndView projectUrl(HttpSession session, Model model) {
	    String sId = (String) session.getAttribute("sId");
	    List<MembersVO> memberList = memberService.getIdx(sId);
	    MembersVO m = memberService.getMemberInfo(sId);
	    
	    if (memberList.isEmpty()) {
	    	model.addAttribute("msg", "�۾����� ������Ʈ�� �����ϴ�.");
	    	return new ModelAndView("fail_back");
	    }

	    MembersVO member = memberList.get(0);
	    System.out.println("��� �׽�Ʈ : " + member);
	    int rewardIdx = member.getReward_idx();
	    int projectIdx = member.getProject_idx();
	    int makerIdx = member.getMaker_idx();

	    if (rewardIdx != 0) {
	        // reward_idx�� 0�� �ƴϸ� projectReward�� �����̷�Ʈ
	        return new ModelAndView("redirect:/projectReward?reward_idx=" + rewardIdx);
	    } else if (makerIdx != 0) {
	    	// project_idx�� 0�� �ƴϸ� projectManagement�� �����̷�Ʈ
	    	return new ModelAndView("redirect:/projectManagement?project_idx=" + projectIdx);
	    }
	    return new ModelAndView("redirect:/projectMaker?member_idx=" + m.getMember_idx());
	}
	
	// ������ ���� ������
	@GetMapping("projectReward")
	public String projectReward(@RequestParam(required = false) Integer reward_idx, HttpSession session, Model model) {
		
		// ���� ���̵� �������� ���� �� 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "�߸��� �����Դϴ�.");
			return "fail_back";
		}
		
		// ���� ��ư�� ������ �� - reward_idx�� �����ϸ� ������ ������ ���� �ش� ������ ���� ��ȸ �� view�� ������ ������ ��� 
		if (reward_idx != null) {
			System.out.println("�����ϱ� ��ư Ŭ�� �� - ������ ��ȣ : " + reward_idx);
			
			// ������ �ۼ��� �Ǻ� ��û
			// ��, ���� ���̵� admin�� �ƴ� ���� ����
			if(!sId.equals("admin")) {
				String rewardWriter = projectService.getRewardAuthorId(reward_idx, sId); // ������ �ۼ����� ���̵� ��ȸ
				if(!sId.equals(rewardWriter)) {
					// ������ �ۼ��ڰ� �ƴ� ���
					model.addAttribute("msg", "������ �ۼ��ڰ� �ƴմϴ�.");
					return "fail_back";
				} 
			}
			
			// ���� ���̵� admin�̰ų� ������ �ۼ����� ���, ������ ���� ��ȸ
			RewardVO reward = projectService.getRewardInfo(reward_idx);
			model.addAttribute("reward", reward);
	    }
		
		return "project/project_reward";
	}
	
	// ������ ����ϱ�
	@PostMapping("saveReward")
    @ResponseBody
    public String saveReward(@ModelAttribute RewardVO reward) {
		System.out.println("saveReward");
		int insertCount = projectService.registReward(reward);
		System.out.println("insertCount : " + insertCount);
		if(insertCount > 0) { return "true"; } return "false";
    }
	
	// ������ �����ϱ�
	@PostMapping("modifyReward")
    @ResponseBody
    public String modifyReward(@ModelAttribute RewardVO reward, @RequestParam int reward_idx, HttpSession session) {
		System.out.println("reward_idx : " + reward_idx);
		int updateCount = projectService.modifyReward(reward);
		System.out.println("updateCount : " + updateCount);
		if(updateCount > 0) { return "true"; } return "false";
    }
	
	// ������ �����ϱ�
	@PostMapping("removeReward")
	@ResponseBody
	public String removeReward(@RequestParam int reward_idx, HttpSession session) {
		System.out.println("�����ϱ� ��ư Ŭ�� �� - ������ ��ȣ : " + reward_idx);
		
		// ���� ���̵� �������� ���� �� 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			return "false";
		}
		
		// ������ �ۼ��� �Ǻ� ��û
		// ��, ���� ���̵� admin�� �ƴ� ���� ����
	    if(!"admin".equals(sId)) {
	        String rewardWriter = projectService.getRewardAuthorId(reward_idx, sId);
	        // ������ �ۼ��ڰ� �ƴ� ���
	        if (!sId.equals(rewardWriter)) {
	            return "false";
	        }
	    }
	    
	    // ������ ���� ó��
	    int deleteCount = projectService.removeReward(reward_idx);
	    if (deleteCount > 0) {
	        return "true";
	    }
	    
	    return "false"; // ������ ���� ���� ��
	}
	
	// ������ ���� ��ȸ�ϱ�
	@GetMapping("rewardCount")
	@ResponseBody
	public String rewardCount(@RequestParam int project_idx) {
		int rewardCount = projectService.getRewardCount(project_idx);
		return rewardCount+"";
	}
	
	// ������ ����Ʈ ��ȸ�ϱ�
	@GetMapping("rewardList")
	@ResponseBody
	public List<RewardVO> rewardList(@RequestParam int project_idx) {
	    List<RewardVO> rList = projectService.getRewardList(project_idx);
	    return rList;
	}
	
	// ����Ŀ ��� ������
	@GetMapping("projectMaker")
	public String makerInfo(HttpSession session, Model model) {
		
		// ���� ���̵� �������� ���� �� 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "�߸��� �����Դϴ�.");
			return "fail_back";
		}
		
		// ����Ŀ ��� ������ ���� �� ���Ǿ��̵�� member_idx�� ��ȸ �� model�� ����
		int member_idx = projectService.getMemberIdx(sId);
		model.addAttribute("member_idx", member_idx);
		return "project/project_maker";
	}
	
	// ����Ŀ ��� ����Ͻ� ���� ó��
	@PostMapping("projectMakerPro")
	public String projectMaker(MakerVO maker, Model model, HttpSession session, HttpServletRequest request) {
		System.out.println(maker);
		String uploadDir = "/resources/upload"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = "";
		
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile mFile1 = maker.getFile1();
		MultipartFile mFile2 = maker.getFile2();
		MultipartFile mFile3 = maker.getFile3();
		MultipartFile mFile4 = maker.getFile4();
		MultipartFile mFile5 = maker.getFile5();
		
		String uuid = UUID.randomUUID().toString();
		
		maker.setMaker_file1("");
		maker.setMaker_file2("");
		maker.setMaker_file3("");
		maker.setMaker_file4("");
		maker.setMaker_file5("");
		
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		String fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		String fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
		String fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
		String fileName5 = uuid.substring(0, 8) + "_" + mFile5.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			maker.setMaker_file1(subDir + "/" + fileName1);
		}
		if(!mFile2.getOriginalFilename().equals("")) {
			maker.setMaker_file2(subDir + "/" + fileName2);
		}
		if(!mFile3.getOriginalFilename().equals("")) {
			maker.setMaker_file3(subDir + "/" + fileName3);
		}
		if(!mFile4.getOriginalFilename().equals("")) {
			maker.setMaker_file4(subDir + "/" + fileName4);
		}
		if(!mFile5.getOriginalFilename().equals("")) {
			maker.setMaker_file5(subDir + "/" + fileName5);
		}
		
		System.out.println("���� ���ε� ���ϸ�1 : " + maker.getMaker_file1());
		System.out.println("���� ���ε� ���ϸ�2 : " + maker.getMaker_file2());
		System.out.println("���� ���ε� ���ϸ�3 : " + maker.getMaker_file3());
		System.out.println("���� ���ε� ���ϸ�4 : " + maker.getMaker_file4());
		System.out.println("���� ���ε� ���ϸ�5 : " + maker.getMaker_file5());
		
		// -----------------------------------------------------------------------------------
		int insertCount = projectService.registMaker(maker);
		
		if(insertCount > 0) { // ����
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
				
				if(!mFile2.getOriginalFilename().equals("")) {
					mFile2.transferTo(new File(saveDir, fileName2));
				}
				
				if(!mFile3.getOriginalFilename().equals("")) {
					mFile3.transferTo(new File(saveDir, fileName3));
				}
				
				if(!mFile4.getOriginalFilename().equals("")) {
					mFile4.transferTo(new File(saveDir, fileName4));
				}
				
				if(!mFile5.getOriginalFilename().equals("")) {
					mFile5.transferTo(new File(saveDir, fileName5));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			// ����Ŀ ��� ���� �� ������Ʈ ��� �������� �̵�
			String targetURL = "projectManagement?maker_idx=" + maker.getMaker_idx();
			System.out.println("����Ŀ ��� ���� �� ����Ŀ ��ȣ ��ȸ : " + maker.getMaker_idx());
			model.addAttribute("msg", "����Ŀ ��Ͽ� �����Ͽ����ϴ�. ������Ʈ ��� �������� �̵��մϴ�.");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else { // ����
			model.addAttribute("msg", "����Ŀ ��� ����!");
			return "fail_back";
		}
	}
	
	// ����Ŀ ������
	@GetMapping("makerDetail")
	public String makerDetail(@RequestParam(required = false) Integer maker_idx, Model model) {
		System.out.println("makerDetail : " + maker_idx);
		MakerVO maker = makerService.getMakerInfo(maker_idx);
		model.addAttribute("maker", maker);
		return "project/maker_detail";
	}
	
	// ����Ŀ �����ϱ� ������
	@GetMapping("modifyMakerForm")
	public String modifyMakerForm(@RequestParam int maker_idx, Model model) {
		System.out.println("modifyMakerForm : " + maker_idx);
		// ����Ŀ ���� ��ȸ
		MakerVO maker = makerService.getMakerInfo(maker_idx);
		model.addAttribute("maker", maker);
		return "project/maker_detail_modifyForm";
	}
	
	// ����Ŀ ������ �����ϱ� ����Ͻ� ���� ó��
	@PostMapping("modifyMaker")
	public String modifyMaker(MakerVO maker, HttpSession session, Model model) {
		System.out.println("modifyMaker");
		String uploadDir = "/resources/upload";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = "";
		
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// ���� ���ε� ���� ��� ���
		System.out.println("���� ���ε� ���� ���: " + saveDir);
		
		MultipartFile mFile1 = maker.getFile4();
		MultipartFile mFile2 = maker.getFile5();
		
		String uuid = UUID.randomUUID().toString();
		maker.setMaker_file4("");
		maker.setMaker_file5("");
		
		String fileName1 = null;
		String fileName2 = null;

		if (mFile1 != null && !mFile1.getOriginalFilename().equals("")) {
		    fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		    maker.setMaker_file4(subDir + "/" + fileName1);
		}

		if (mFile2 != null && !mFile2.getOriginalFilename().equals("")) {
		    fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		    maker.setMaker_file5(subDir + "/" + fileName2);
		}

		System.out.println("���� ���ε� ���ϸ�1 : " + maker.getMaker_file4());
		System.out.println("���� ���ε� ���ϸ�2 : " + maker.getMaker_file5());
		// -----------------------------------------------------------------------------------
		int updateCount = makerService.modifyMaker(maker);
		
		if(updateCount > 0) {
			// ���� ���ε� ó��
			try {
			    if (fileName1 != null) {
			        mFile1.transferTo(new File(saveDir, fileName1));
			    }
			    if (fileName2 != null) {
			        mFile2.transferTo(new File(saveDir, fileName2));
			    }
			} catch (IllegalStateException e) {
			    e.printStackTrace();
			} catch (IOException e) {
			    e.printStackTrace();
			}
			// ����Ŀ ���� ���� �� makerDetail�� �̵�
			String targetURL = "makerDetail?maker_idx=" + maker.getMaker_idx();
			System.out.println("����Ŀ idx : " + maker.getMaker_idx());
			model.addAttribute("msg", "����Ŀ ���� ������ �Ϸ�Ǿ����ϴ�.");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else {
			model.addAttribute("msg", "�� ���� ����!");
			return "fail_back";
		}
	}
	
	// ����Ŀ ������ �����ϱ� - ���� �ǽð� ����
	@PostMapping("deleteFile")
	@ResponseBody
	public String deleteFile(int maker_idx,	String fileName, int fileNumber, HttpSession session) {
		System.out.println("deleteFile() - fileName : " + fileName);
		// ���� ���� ��û
	    int deleteCount = makerService.removeMakerFile(maker_idx, fileName, fileNumber);
	    if (deleteCount != 0) {
	        // ���� ���� ����
	        String uploadDir = "/resources/upload";
	        String saveDir = session.getServletContext().getRealPath(uploadDir);
	        String filePath = saveDir + "/" + fileName;
	        File file = new File(filePath);
	        if (file.exists()) {
	            if (file.delete()) {
	                return "success";
	            } else {
	                return "fail";
	            }
	        } else {
	            // ������ �̹� �����Ǿ� ����
	            return "success";
	        }
	    } else {
	        return "fail";
	    }
	} // deleteFile
	
	// ������Ʈ ��� ������
	@GetMapping("projectManagement")
	public String projectManagement(HttpSession session, Model model) {
		
		// ���� ���̵� �������� ���� �� 
//		String sId = (String) session.getAttribute("sId");
//		if(sId == null) {
//			model.addAttribute("msg", "�߸��� �����Դϴ�.");
//			return "fail_back";
//		}
		
		return "project/project_management";
	}
	
	// ������Ʈ ��� ����Ͻ� ���� ó��
	@PostMapping("projectManagementPro")
	public String projectManagementPro(ProjectVO project, Model model, HttpSession session, HttpServletRequest request) {
		
		// �̹��� ���� ���ε� 
		String uploadDir = "/resources/upload";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = "";
		
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile mFile1 = project.getFile1();
		MultipartFile mFile2 = project.getFile2();
		MultipartFile mFile3 = project.getFile3();
		MultipartFile mFile4 = project.getFile4();
		MultipartFile mFile5 = project.getFile5();
		
		String uuid = UUID.randomUUID().toString();
		
		project.setProject_thumnails1("");
		project.setProject_thumnails2("");
		project.setProject_thumnails3("");
		project.setProject_image("");
		project.setProject_settlement_image("");
		
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		String fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		String fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
		String fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
		String fileName5 = uuid.substring(0, 8) + "_" + mFile5.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			project.setProject_thumnails1(subDir + "/" + fileName1);
		}
		if(!mFile2.getOriginalFilename().equals("")) {
			project.setProject_thumnails2(subDir + "/" + fileName2);
		}
		if(!mFile3.getOriginalFilename().equals("")) {
			project.setProject_thumnails3(subDir + "/" + fileName3);
		}
		if(!mFile4.getOriginalFilename().equals("")) {
			project.setProject_image(subDir + "/" + fileName4);
		}
		if(!mFile5.getOriginalFilename().equals("")) {
			project.setProject_settlement_image(subDir + "/" + fileName5);
		}
		
		System.out.println("���� ���ε� ����ϸ�1:" + project.getProject_thumnails1());
		System.out.println("���� ���ε� ����ϸ�2:" + project.getProject_thumnails1());
		System.out.println("���� ���ε� ����ϸ�3:" + project.getProject_thumnails1());
		System.out.println("���� ���ε� ���̹�����:" + project.getProject_image());
		System.out.println("���� ���ε� ����纻��:" + project.getProject_settlement_image());
		
		// ------------------------------------------------------------------------------------
		
		// �ֹε�Ϲ�ȣ ����
		String representativeBirth1 = request.getParameter("representativeBirth1"); // ���ڸ�
		String representativeBirth2 = request.getParameter("representativeBirth2"); // ���ڸ�
		String project_representative_birth = representativeBirth1 + "-" + representativeBirth2; // ����
		project.setProject_representative_birth(project_representative_birth); // ����
		
		// �ؽ��±� �� ó��
		String project_hashtag = request.getParameter("project_hashtag");
		project.setProject_hashtag(project_hashtag);
		System.out.println("�ؽ��±�: " + project.getProject_hashtag());
		
		int insertCount = projectService.registProject(project);
		
		if(insertCount > 0) { // ���� �� 
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
				
				if(!mFile2.getOriginalFilename().equals("")) {
					mFile2.transferTo(new File(saveDir, fileName2));
				}
				
				if(!mFile3.getOriginalFilename().equals("")) {
					mFile3.transferTo(new File(saveDir, fileName3));
				}
				
				if(!mFile4.getOriginalFilename().equals("")) {
					mFile4.transferTo(new File(saveDir, fileName4));
				}
				
				if(!mFile5.getOriginalFilename().equals("")) {
					mFile5.transferTo(new File(saveDir, fileName5));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			// ������Ʈ ��� ���� �� ������ ���� �������� �̵�
			String targetURL = "projectReward?project_idx=" + project.getProject_idx();
			System.out.println("������Ʈ ��� ���� �� ������Ʈ ��ȣ ��ȸ : " + project.getProject_idx());
			model.addAttribute("msg", "������Ʈ ��Ͽ� �����Ͽ����ϴ�. ������ ���� �������� �̵��մϴ�.");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else { // ���� ��
			model.addAttribute("msg", "������Ʈ ��� ����!");
			return "fail_back";
		}
	}
	
	// �߼ۡ�ȯ�� ����
	@GetMapping("projectShipping")
	public String projectShipping(HttpSession session, Model model) {
		
		// ���� ���̵� �������� ���� �� 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "�߸��� �����Դϴ�.");
			return "fail_back";
		}
		
		// ���� ���̵�� member_idx ��ȸ 
		int member_idx = projectService.getMemberIdx(sId);
		
		// ������Ʈ ����Ʈ �����ͼ� Model ��ü�� ����
		List<ProjectVO> projectList = projectService.getProjectList(member_idx);
		model.addAttribute("projectList", projectList);
		
		return "project/project_shipping";
	}
	
	// 발송·환불 관리 - 서포터 관리 출력
	@ResponseBody
	@PostMapping("shippingStatus")
	public Map<String, Object> shippingStatus(@RequestParam("project_idx") int project_idx) {
		Map<String, Object> data = new HashMap<>();
		
		// ��ۻ�Ȳ ��ȸ
		List<Map<String, Object>> deliveryStatus = paymentService.getDeliveryList(project_idx);
		
		// ȯ�ҽ��ο��� ��ȸ
		List<Map<String, Object>> refundStatus = paymentService.getRefundList(project_idx);
		
		System.out.println("������Ʈ ��ȣ: " + project_idx);
		System.out.println("��ۻ�Ȳ: " + deliveryStatus);
		System.out.println("ȯ�ҽ��ο���: " + refundStatus);
		
		data.put("deliveryStatus", deliveryStatus);
		data.put("refundStatus", refundStatus);
		
		return data;
	}
	
	// 발송·환불 관리 - 목록 출력
	@ResponseBody
	@PostMapping("shippingList")
	public List<PaymentVO> shippingList(@RequestParam int project_idx, 
										@RequestParam(value="filter", required = false) String filter, 
										@RequestParam(value="type", required = false) String type) {
		List<PaymentVO> data = new ArrayList<>();
		
		if(filter != null) { // delivery_status(배송상황)가 있을 때 목록 조회
			List<PaymentVO> deliveryAllList = paymentService.getDeliveryAllList(project_idx, filter);
			data.addAll(deliveryAllList);
		} else if(type != null) { // payment_confirm(환불승인여부)가 있을 때 목록 조회
			List<PaymentVO> refundAllList = paymentService.getRefundAllList(project_idx, type);
			data.addAll(refundAllList); 
		}
		
		System.out.println("data : " + data);
		return data;
	}
	
	// 수수료·정산 관리
	@GetMapping("projectSettlement")
	public String projectSettlement() {
		return "project/project_settlement";
	}
	
	@GetMapping("mypage")
	public String mypage() {
		return "myPage";
	}
	
	// �׽�Ʈ ������
	@GetMapping("projectTest")
	public String projectTest(Model model, HttpSession session) {
		return "project/project_test";
	}
	
	// ������Ʈ ��Ȳ
	// ������ �ε� �� ���� 7�ϰ� ���� �ݾ� ��Ʈ�� �ҷ���
	@GetMapping("projectStatus")
	public String projectStatus(
			@RequestParam(required = false) Integer maker_idx, 
			@RequestParam(required = false) Integer project_idx, 
			HttpSession session, Model model) {
		System.out.println("projectStatus");

		// ����Ŀ�� ���� 7�ϰ� ���� �ݾ� ��ȸ
		List<PaymentVO> payList = paymentService.getPaymentListAmountBy7Day(maker_idx);
		// ����Ŀ�� ���� 7�ϰ� ������ �� ��ȸ
		List<PaymentVO> supporterList = paymentService.getSupporterListCountBy7Day(maker_idx);

		// Gson ��ü ����
		Gson gson = new Gson();

		// JsonArray ��ü ����
		JsonArray payArray = new JsonArray(); // ���� �ݾ�
		JsonArray supporterArray = new JsonArray(); // ������ ��

		// ���� �ʱ�ȭ
		int totalAmount = 0; // ���� ���� �ݾ�
		int todayAmount = 0; // ���� ���� �ݾ�

		// payList���� �ϳ��� ������ JsonObject�� �����ϰ� payArray�� �߰�
		for (PaymentVO pay : payList) {
		    JsonObject object = new JsonObject();
		    object.addProperty("date", pay.getDate());
		    object.addProperty("amount", pay.getAmount());
		    payArray.add(object);

		    // ���� ���� �ݾ� ���
		    totalAmount += pay.getAmount();

		    // ���� ���� �ݾ� ��� (���� ��¥�� ��ġ�ϴ� ���)
		    LocalDate today = LocalDate.now();
		    LocalDate paymentDate = LocalDate.parse(pay.getDate());
		    if (today.isEqual(paymentDate)) {
		        todayAmount += pay.getAmount();
		    }
		}

		// supporterList���� �ϳ��� ������ JsonObject�� �����ϰ� supporterArray�� �߰�
		for (PaymentVO supporter : supporterList) {
		    JsonObject object = new JsonObject();
		    object.addProperty("date", supporter.getDate());
		    object.addProperty("supporterCount", supporter.getCount());
		    supporterArray.add(object);
		}

		// json ���ڿ��� ��ȯ �� Model�� ����
		String payListAmount = gson.toJson(payArray);
		String supporterListCount = gson.toJson(supporterArray);
		model.addAttribute("payListAmount", payListAmount);
		model.addAttribute("todayAmount", todayAmount); // ���� ���� �ݾ�
		model.addAttribute("totalAmount", totalAmount); // ���� ���� �ݾ�
		model.addAttribute("supporterListCount", supporterListCount); // ���� 7�ϰ� ������ ��
		
		// ==============================================
		
		// ������Ʈ�� ���� 7�ϰ� ���� �ݾ� ��ȸ
		List<PaymentVO> projectPayList = paymentService.getProjectDailyPayment(project_idx);
		// ������Ʈ�� ���� 7�ϰ� ������ �� ��ȸ
		List<PaymentVO> projectSupporterList = paymentService.getProjectSupporterCount(project_idx);
		
		
		
		
		return "project/project_status";

	}
	
	// ������, ������ => ���� ����
	// maker_idx(�Ķ����)�� �޾Ƽ� ��Ʈ�� �ҷ���
	@GetMapping("/chartData")
    @ResponseBody
    public ChartDataVO getChartData(
    		@RequestParam String startDate, @RequestParam String endDate, @RequestParam("maker_idx") int maker_idx, Model model) {
        // ��¥ ������ �����ϴ� DateTimeFormatter ��ü ����
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // �����ϰ� �������� �Ľ��Ͽ� LocalDate ��ü�� ��ȯ
        LocalDate parsedStartDate = LocalDate.parse(startDate, formatter);
        LocalDate parsedEndDate = LocalDate.parse(endDate, formatter);
        System.out.println("parsedStartDate : " + parsedStartDate);
        System.out.println("parsedEndDate : " + parsedEndDate);
        System.out.println("����Ŀ ��ȣ : " + maker_idx);

        // ����Ŀ�� ���� �ݾ� ��ȸ
        List<PaymentVO> paymentList = paymentService.getPaymentListCountByDay(parsedStartDate, parsedEndDate, maker_idx);

        // ����Ŀ�� ������ �� ��ȸ
        List<PaymentVO> supporterList = paymentService.getSupporterListCountByDay(parsedStartDate, parsedEndDate, maker_idx);

        // ��Ʈ�� ���� ��, �Ϻ� ���� �ݾ�, ���� ���� �ݾ�, �Ϻ� ������ ��, ���� ������ ���� ������ ����Ʈ �ʱ�ȭ
        List<String> labels = new LinkedList<>();
        List<Integer> dailyPaymentAmounts = new LinkedList<>();
        List<Integer> cumulativePaymentAmounts = new LinkedList<>();
        List<Integer> dailySupporterCounts = new LinkedList<>();
        List<Integer> cumulativeSupporterCounts = new LinkedList<>();

        int cumulativePaymentAmount = 0;
        int cumulativeSupporterCount = 0;

        // paymentList���� �ϳ��� �����鼭 ����Ʈ�� ����
        for (PaymentVO payment : paymentList) {
            String dateString = payment.getDate(); // ����� �÷����� 'date'�� ���
            labels.add(dateString); // �󺧿� ��¥ �߰�
            cumulativePaymentAmount += payment.getAmount(); // ���� ���� �ݾ� ���
            dailyPaymentAmounts.add(payment.getAmount()); // �Ϻ� ���� �ݾ� �߰�
            cumulativePaymentAmounts.add(cumulativePaymentAmount); // ���� ���� �ݾ� �߰�
        }

        int supporterIndex = 0; // ������ �� ������ �ε���

        for (String label : labels) {
            if (supporterIndex < supporterList.size()) {
                PaymentVO supporterData = supporterList.get(supporterIndex);
                String dateString = supporterData.getDate(); // ����� �÷����� 'date'�� ���

                if (label.equals(dateString)) {
                    cumulativeSupporterCount += supporterData.getCount(); // ���� ������ �� ����
                    cumulativeSupporterCounts.add(cumulativeSupporterCount); // ���� ������ �� �߰�
                    dailySupporterCounts.add(supporterData.getCount()); // �Ϻ� ������ �� �߰�
                    supporterIndex++; // ���� ������ �� �����ͷ� �̵�
                    continue;
                }
            }
            dailySupporterCounts.add(0); // ������ ��¥�� ���� 0���� ó���� �Ϻ� ������ �� �߰�
            cumulativeSupporterCounts.add(cumulativeSupporterCount); // ������ ���� ������ �� �߰� (���� �����͸� �״�� ���)
        }

        // ChartDataVO ��ü�� �����Ͽ� ��, �Ϻ� ���� �ݾ�, ���� ���� �ݾ�, �Ϻ� ������ ��, ���� ������ ���� ��� ��ȯ
        return new ChartDataVO(labels, dailyPaymentAmounts, cumulativePaymentAmounts, dailySupporterCounts, cumulativeSupporterCounts);
    }
	
}