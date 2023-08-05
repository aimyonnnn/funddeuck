package com.itwillbs.test.controller;

import javax.servlet.http.HttpSession;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.IdeaCommunityService;
import com.itwillbs.test.vo.IdeaCommunityVO;

@Controller
@RequestMapping("/member")
public class IdeaCommunityController {

    @Autowired
    private IdeaCommunityService ideaCommunityService;

    @GetMapping("/memberideacommunity")
    public String ideaCommunity(Model model, HttpSession session) {
        Integer memberIdx = (Integer) session.getAttribute("sIdx");
        if (memberIdx == null) {
            return "redirect:/";
        }
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
    @ResponseBody
    public List<IdeaCommunityVO> getCardsData() {
        List<IdeaCommunityVO> cardsData = ideaCommunityService.getAllCardData();

        return cardsData;
    }
    
}
