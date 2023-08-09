package com.itwillbs.test.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itwillbs.test.service.IdeaCommunityService;
import com.itwillbs.test.vo.IdeaCommunityVO;

@Controller
@RequestMapping
public class IdeaCommunityController {

    @Autowired
    private IdeaCommunityService ideaCommunityService;
    
    @Autowired
    private HttpServletRequest request;

    @GetMapping("/memberideacommunity")
    public String ideaCommunity(Model model, HttpSession session) {
        Integer memberIdx = (Integer) session.getAttribute("sIdx");
        if (memberIdx == null) {
            return "redirect:/";
        }

        List<IdeaCommunityVO> cardsData = ideaCommunityService.getAllCardData();
        model.addAttribute("data", cardsData);

        return "member/member_ideacommunity";
    }

    @PostMapping("/saveIdea")
    @ResponseBody
    public void saveIdea(@ModelAttribute IdeaCommunityVO ideaCommunityVO, HttpSession session) {
        Integer memberIdx = (Integer) session.getAttribute("sIdx");
        if (memberIdx == null) {
            return;
        }

        ideaCommunityVO.setMember_idx(memberIdx);

        ideaCommunityService.saveIdea(ideaCommunityVO);
    }

    @GetMapping("/getCardsData")
    public List<IdeaCommunityVO> getCardsData() {
        List<IdeaCommunityVO> cardsData = ideaCommunityService.getAllCardData();

        return cardsData;
    }

    @PostMapping("/likeIdea")
    @ResponseBody
    public void likeIdea(@RequestParam("ideaIdx") int ideaIdx) {
        IdeaCommunityVO idea = ideaCommunityService.getIdeaById(ideaIdx);

        if (idea != null) {
            idea.setLikecount(idea.getLikecount() + 1);
            ideaCommunityService.updateIdea(idea);
        }
    }
    
    @PostMapping("/deleteIdea")
    @ResponseBody
    public String deleteIdea(@RequestParam("ideaIdx") int ideaIdx, HttpSession session) {
    	
        String memberId = (String) session.getAttribute("sId");
        if (memberId != null) {
            int deleteCount = ideaCommunityService.deleteIdea(ideaIdx, memberId);
            if(deleteCount > 0) return "true";
        }
        
        return "false";
        
    }

}
