package ${packageName}.presenter;

import android.support.annotation.NonNull;
import io.reactivex.android.schedulers.AndroidSchedulers;

public class ${className}Presenter extends BasePresenter<${className}Contract.View, ${className}Contract.Model> implements ${className}Contract.Presenter {

    private final String TAG = ${className}Presenter.class.getSimpleName();

    public ${className}Presenter(${className}Contract.View mView) {
        super(mView);
    }

    @NonNull
    @Override
    protected ${className}Contract.Model createModel() {
        return new ${className}Model();
    }

    @Override
    public void start(Object request) {
    }

}