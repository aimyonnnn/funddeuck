package com.itwillbs.test;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.MainService;
import com.itwillbs.test.vo.MainVO;

@Controller
public class HomeController {

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    private final MainService mainService;

    @Autowired
    public HomeController(MainService mainService) {
        this.mainService = mainService;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
        logger.info("Welcome home! The client locale is {}.", locale);

        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        String formattedDate = dateFormat.format(date);
        model.addAttribute("serverTime", formattedDate);

        List<MainVO> projects = mainService.getAllProjects();

        model.addAttribute("projects", projects);

        return "main";
    }

    @RequestMapping(value = "/get_ranking_data", method = RequestMethod.GET)
    @ResponseBody
    public List<MainVO> getRankingData() {
        List<MainVO> rankingData = mainService.getRankingData();
        return rankingData;
    }
    
    
}
