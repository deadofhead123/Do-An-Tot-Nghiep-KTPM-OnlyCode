package com.javaweb.converter;

import com.javaweb.entity.NewsEntity;
import com.javaweb.model.dto.NewsDTO;
import com.javaweb.model.response.NewsSearchResponse;
import com.javaweb.util.HotType;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class NewsConverter {
    private final ModelMapper modelMapper;

    public NewsEntity convertToEntity(NewsDTO newsDTO, NewsEntity oldNewsEntity){
        NewsEntity latestNewsEntity = modelMapper.map(newsDTO, NewsEntity.class);

        if(oldNewsEntity == null){
            latestNewsEntity.setView(0L);
            latestNewsEntity.setHot(HotType.NO.toString());
        }
        else{
            latestNewsEntity.setImage(oldNewsEntity.getImage());
            latestNewsEntity.setCreatedAt(oldNewsEntity.getCreatedAt());
            latestNewsEntity.setCreatedBy(oldNewsEntity.getCreatedBy());
        }

        latestNewsEntity.setIsActive(1);

        return latestNewsEntity;
    }

    public NewsDTO convertToDTO(NewsEntity newsEntity){
        if(newsEntity == null) return null;
        else return modelMapper.map(newsEntity, NewsDTO.class);
    }

    public NewsSearchResponse convertToSearchResponse(NewsEntity newsEntity){
        return modelMapper.map(newsEntity, NewsSearchResponse.class);
    }
}
